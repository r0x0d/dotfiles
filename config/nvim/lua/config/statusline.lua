local icons = require("config.icons")
local fmt = string.format
local M = {}

-- Layout: "editor state" on the left, "facts about this buffer" on the right.
--   🛸 NORMAL │ 🌿 feature/x 🌱3 🍂1 │ 📋 task    statusline.lua ●  🌙 │ 🌙🧹  🚨2  42:7  38%
--
-- Two quirks of %{...} drive the shape of this file:
--   1. its output is inserted verbatim: no %#group# and no %% escapes inside.
--   2. Neovim eats a leading space of the result in several positions, so a
--      fragment never starts with one: each returns text + trailing space and
--      the static spec owns every leading space (see `build_spec` below).

-- ── highlights ───────────────────────────────────────────────────────────────
-- Colours are resolved from the active colorscheme instead of hard-coded, so
-- swapping tokyonight for something else keeps the bar readable.
local MODE_COLOR = {
  Normal = "Function",
  Insert = "String",
  Visual = "Statement",
  Replace = "ErrorMsg",
  Command = "WarningMsg",
  Terminal = "DiagnosticInfo",
}

-- vim.fn.mode() / ModeChanged's new_mode -> colour family (see MODE_COLOR)
local MODE_FAMILY = {
  n = "Normal", no = "Normal", nov = "Normal", noV = "Normal", ["no\22"] = "Normal",
  i = "Insert", ic = "Insert", ix = "Insert",
  v = "Visual", V = "Visual", ["\22"] = "Visual", ["\19"] = "Visual", s = "Visual", S = "Visual",
  R = "Replace", Rc = "Replace", Rx = "Replace", Rv = "Replace", Rvc = "Replace", Rvx = "Replace",
  c = "Command", cv = "Command", ce = "Command", cr = "Command",
  t = "Terminal",
}

local function hl_attrs(group)
  local ok, attrs = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  return ok and attrs or {}
end

local function fg(group) return hl_attrs(group).fg end
local function dim() return { fg = fg("StatusLineNC") or fg("Comment") } end

local function apply_highlights()
  vim.api.nvim_set_hl(0, "StatusLineSep", { fg = fg("Comment") })
  vim.api.nvim_set_hl(0, "StatusLineDim", dim())
  vim.api.nvim_set_hl(0, "StatusLineFile", { bold = true })
  vim.api.nvim_set_hl(0, "StatusLineMod", { fg = fg("DiagnosticWarn") or fg("WarningMsg"), bold = true })
  vim.api.nvim_set_hl(0, "StatusLineGit", { fg = fg("Function"), bold = true })
  vim.api.nvim_set_hl(0, "StatusLineAdd", { fg = fg("DiagnosticOk") or fg("String") })
  vim.api.nvim_set_hl(0, "StatusLineChange", { fg = fg("DiagnosticWarn") or fg("WarningMsg") })
  vim.api.nvim_set_hl(0, "StatusLineRemove", { fg = fg("DiagnosticError") or fg("ErrorMsg") })
  for _, p in ipairs({
    { "Error", "DiagnosticError" }, { "Warn", "DiagnosticWarn" },
    { "Info", "DiagnosticInfo" }, { "Hint", "DiagnosticHint" },
  }) do
    vim.api.nvim_set_hl(0, "StatusLine" .. p[1], { fg = fg(p[2]) })
  end
end

-- The mode pill needs one highlight name whose colour changes with the mode,
-- which a spec-time %#Group# can't express; repaint it on ModeChanged instead.
local function paint_mode(mode)
  mode = mode or vim.fn.mode()
  local family = MODE_FAMILY[mode] or MODE_FAMILY[mode:sub(1, 1)] or "Normal"
  vim.api.nvim_set_hl(0, "StatusLineMode", {
    fg = hl_attrs("StatusLine").bg, bg = fg(MODE_COLOR[family]), bold = true,
  })
end

-- ── helpers ──────────────────────────────────────────────────────────────────
local function cur() return vim.api.nvim_get_current_buf() end

-- Keep the tail of long refs: "origin/feature/really-long-name" is better
-- served by "…/really-long-name" than by "origin/feature/reall…".
local function trunc_left(s, max)
  if vim.fn.strdisplaywidth(s) <= max then return s end
  return "…" .. vim.fn.strcharpart(s, vim.fn.strchars(s) - max + 1)
end

-- Squeeze before cutting: "super/long/path/to/file.py" -> "s/l/p/t/file.py".
-- Vim's pathshorten() does exactly that (it also leaves ".." alone and keeps a
-- dot-directory at two characters), so paths only get squeezed once they are
-- over budget: squeezing keeps every level visible, truncating hides an end.
local function squeeze_path(s, max)
  if vim.fn.strdisplaywidth(s) <= max then return s end
  return trunc_left(vim.fn.pathshorten(s), max)
end

-- ── mode ─────────────────────────────────────────────────────────────────────
function M.mode()
  local m = vim.fn.mode()
  local icon, name = unpack(icons.modes[m] or icons.modes[m:sub(1, 1)] or icons.modes.n)
  return icon .. " " .. name .. " "
end

-- ── git ──────────────────────────────────────────────────────────────────────
-- Everything comes from gitsigns (branch + diffstats); no git processes run.
-- The statusline is redrawn constantly, so shelling out here is not an option;
-- the segments are simply empty until gitsigns has attached to the buffer.
local function git_state(buf)
  local d = vim.b[buf].gitsigns_status_dict
  if not d or not d.head or d.head == "" then return nil end
  return { branch = squeeze_path(d.head, 32), diff = d }
end

function M.git_sep() return git_state(cur()) and "│ " or "" end
function M.git_icon() return git_state(cur()) and (icons.git.branch .. " ") or "" end

function M.git_branch()
  local s = git_state(cur())
  return s and (s.branch .. " ") or ""
end

for _, p in ipairs({
  { "git_added", "added" }, { "git_changed", "changed" }, { "git_removed", "removed" },
}) do
  M[p[1]] = function()
    local s = git_state(cur())
    local n = s and s.diff[p[2]] or 0
    return n > 0 and (icons.git[p[2]] .. n .. " ") or ""
  end
end

-- ── taskwarrior ──────────────────────────────────────────────────────────────
-- The plugin caches `task export` behind this for 15s (our own memo below is 1s); pcall keeps the
-- statusline alive before the "taskwarrior" group has loaded (or without it).
-- Both the module handle and the rendered text are memoised: a failed require()
-- walks the runtimepath every time it is called, and the bar is redrawn on
-- every keystroke.
local task = { module = nil, text = nil, at = 0, retry_at = 0 }

local function task_text()
  local now = vim.uv.now()
  if task.module then
    if now - task.at < 1000 then return task.text end
  elseif now < task.retry_at then
    return nil
  end
  local ok, tw = pcall(require, "taskwarrior.statusline")
  if not ok then
    task.retry_at = now + 2000
    task.text = nil
    return nil
  end
  task.module, task.at = tw, now
  local ok2, s = pcall(tw.render)
  if not ok2 or type(s) ~= "string" or s == "" then
    task.text = nil
    return nil
  end
  s = s:gsub("^task:%s*", "")
  if vim.fn.strdisplaywidth(s) > 40 then s = vim.fn.strcharpart(s, 0, 39) .. "…" end
  task.text = s
  return s
end

function M.task_sep() return task_text() and "│ " or "" end

function M.task()
  local s = task_text()
  return s and (s .. " ") or ""
end

-- ── right block: the buffer ──────────────────────────────────────────────────
-- pcall: the bar can be drawn while a client is mid-teardown.
local function lsp_clients(buf)
  local ok, clients = pcall(vim.lsp.get_clients, { bufnr = buf })
  return ok and clients or {}
end

function M.file_name()
  local buf = cur()
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    local kind = vim.bo[buf].buftype
    return (kind ~= "" and kind or "—") .. " "
  end
  -- ":~:." gives cwd-relative when the file is below cwd, home-relative when
  -- it is below $HOME, and only falls back to absolute for anything else.
  return squeeze_path(vim.fn.fnamemodify(name, ":~:."), 48) .. " "
end

-- Modified wins over readonly: unsaved changes are the more urgent signal.
function M.file_mod()
  if vim.bo.modified then return "● " end
  if vim.bo.readonly then return "🔒 " end
  return ""
end

-- require() of a lazy plugin and get_icon() are both far too slow to run on
-- every redraw, so the handle and the rendered label are cached per buffer.
-- nil = not resolved yet, false = unavailable (retried every few seconds, since
-- the plugin may still be installing/loading when the first redraw happens).
local devicons, devicons_retry = nil, 0
local ft_cache = {} -- bufnr -> { ft = , name = , icon = , hl = }

local function devicons_module()
  if devicons ~= nil then return devicons or nil end
  if vim.uv.now() < devicons_retry then return nil end
  local ok, dev = pcall(require, "nvim-web-devicons")
  devicons = ok and dev or false
  devicons_retry = vim.uv.now() + 5000
  return devicons or nil
end

-- Resolves a buffer's filetype into { ft, icon, hl }: `hl` is the devicons
-- highlight group ("DevIconPy") that the statusline links its own group to.
local function ft_parts(buf)
  local ft = vim.bo[buf].filetype
  if ft == "" then return nil end
  local name = vim.api.nvim_buf_get_name(buf)
  local c = ft_cache[buf]
  if c and c.ft == ft and c.name == name then return c end
  local icon, hl = "", nil
  local dev = devicons_module()
  if dev then
    if name ~= "" then
      icon, hl = dev.get_icon(name, ft, { default = false })
    end
    -- get_icon() answers "" (not nil) when the extension is unknown, which
    -- would otherwise mask a perfectly good filetype icon for e.g. "notes.py.txt".
    if icon == nil or icon == "" then
      icon, hl = dev.get_icon_by_filetype(ft, { default = false })
    end
  end
  c = { ft = ft, name = name, icon = icons.ft[ft] or icon or "", hl = hl }
  ft_cache[buf] = c
  return c
end

function M.ft_sep() return ft_parts(cur()) and "│ " or "" end

function M.ft_icon()
  local p = ft_parts(cur())
  return (p and p.icon ~= "") and (p.icon .. " ") or ""
end

-- The name is a last resort: only when neither devicons nor an LSP client
-- gives the buffer an icon to stand in for it.
function M.filetype()
  local p = ft_parts(cur())
  if not p or p.icon ~= "" then return "" end
  for _, c in ipairs(lsp_clients(cur())) do
    if icons.lsp[c.name] then return "" end
  end
  return p.ft .. " "
end

-- ── diagnostics ──────────────────────────────────────────────────────────────
-- Counts are recomputed on DiagnosticChanged and cached: four filtered
-- vim.diagnostic.get() calls on every redraw is wasteful in large buffers.
local DIAG = {
  { "error", vim.diagnostic.severity.ERROR },
  { "warn", vim.diagnostic.severity.WARN },
  { "info", vim.diagnostic.severity.INFO },
  { "hint", vim.diagnostic.severity.HINT },
}
local diag_count = {} -- bufnr -> { [severity] = n }

-- vim.diagnostic.count() is lazily seeded for buffers that never fired
-- DiagnosticChanged (the BufEnter handler below refreshes it too).
local function counts(buf)
  local c = diag_count[buf]
  if not c then
    c = vim.diagnostic.count(buf)
    diag_count[buf] = c
  end
  return c
end

local function diag_total(buf)
  local c, total = counts(buf), 0
  for _, d in ipairs(DIAG) do total = total + (c[d[2]] or 0) end
  return total
end

function M.diag_sep() return diag_total(cur()) > 0 and "│ " or "" end

-- Each severity is its own segment so it can carry its own colour.
for i, d in ipairs(DIAG) do
  M["diag_" .. d[1]] = function()
    local n = counts(cur())[d[2]] or 0
    return n > 0 and (icons.diagnostics[d[1]] .. n .. " ") or ""
  end
end

-- ── lsp ──────────────────────────────────────────────────────────────────────
-- The filetype icon switches to the language colour while a server is
-- attached, and each attached client gets its own icon after the filetype.
-- devicons publishes one highlight group per language (DevIconPy, DevIconRs…).
-- Linking to it keeps our icon coloured correctly even when the colorscheme or
-- devicons reload; the fallback is the dim bar colour.
local function lang_group(ft, dev_hl)
  local name = "StatusLineLang_" .. (ft:gsub("[^%w]", "_"))
  local target = (dev_hl and vim.fn.hlexists(dev_hl) == 1) and dev_hl or "StatusLineDim"
  vim.api.nvim_set_hl(0, name, { link = target })
  return name
end

-- One icon per attached client (see icons.lsp), ⚙️ for unmapped ones. Deduped by
-- name: a server attached through several roots/instances shows once.
function M.lsp_icons()
  local out, seen = {}, {}
  for _, c in ipairs(lsp_clients(cur())) do
    local icon = icons.lsp[c.name] or "⚙️"
    if not seen[c.name] then
      seen[c.name] = true
      out[#out + 1] = icon
    end
  end
  return #out > 0 and (table.concat(out) .. " ") or ""
end

-- Clicking the branch opens the branch picker, the diagnostics open Trouble
-- for the current buffer. Both commands load their (lazy) plugin on demand.
function M.git_click(_, _, button)
  if button == "l" then vim.cmd("Telescope git_branches") end
end

function M.diag_click(_, _, button)
  if button == "l" then vim.cmd("Trouble diagnostics toggle filter.buf=0") end
end

-- Divider between the language icon and the servers, only when both exist.
function M.lsp_sep()
  local p = ft_parts(cur())
  return (p and p.icon ~= "" and M.lsp_icons() ~= "") and "│ " or ""
end

-- Terminals report no hover, so the "tooltip" is a click on the icons.
-- Wired through %@v:lua.Statusline.lsp_click@ ... %X in build_spec; the handler
-- receives (minwid, clicks, button, mods), only the button matters here.
function M.lsp_click(_, _, button)
  if button ~= "l" then return end
  local lines = {}
  for _, c in ipairs(lsp_clients(cur())) do
    local root = c.root_dir and vim.fn.fnamemodify(c.root_dir, ":~") or "single file"
    lines[#lines + 1] = fmt("%s %s  (%s)", icons.lsp[c.name] or "⚙️", c.name, root)
  end
  if #lines > 0 then vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "LSP" }) end
end

-- Fixed-width fields (%-3d / %3d) so the bar doesn't jitter while moving.
-- Right-aligned by construction: the percentage is the last thing on the bar.
function M.pos()
  local l, c = vim.fn.line("."), vim.fn.col(".")
  local total = vim.fn.line("$")
  local pct = total <= 1 and 100 or math.floor(100 * (l - 1) / (total - 1) + 0.5)
  return fmt("%d:%-3d %3d%%", l, c, pct)
end

_G.Statusline = M

apply_highlights()
paint_mode()

-- Static %#Group# wrapper per coloured fragment: the functions supply only the
-- text, because their return value is not re-parsed for highlights.
local function seg(group, fn)
  return fmt("%%#%s#%%{v:lua.Statusline.%s()}", group, fn)
end

-- The single part of the bar that cannot be static: the language icon needs the
-- colour of *this* buffer's language, and a %{...} result can't switch groups.
-- So the spec is composed per window (only on enter/attach) while every other
-- segment stays a live expression.
local function build_spec(buf)
  local p = ft_parts(buf)
  local icon_group = "StatusLineDim"
  if p and p.icon ~= "" then
    -- Coloured only while a server is attached: a dim icon means "no LSP".
    icon_group = lang_group(p.ft, #lsp_clients(buf) > 0 and p.hl or nil)
  end

  return table.concat({
    -- left: who am I, where am I. The space before the pill is static so the
    -- pill stays symmetric (leading spaces from an expression get eaten).
    "%#StatusLineMode# ",
    seg("StatusLineMode", "mode"),
    seg("StatusLineSep", "git_sep"),
    "%@v:lua.Statusline.git_click@",
    seg("StatusLineGit", "git_icon"),
    seg("StatusLineGit", "git_branch"),
    "%X",
    seg("StatusLineAdd", "git_added"),
    seg("StatusLineChange", "git_changed"),
    seg("StatusLineRemove", "git_removed"),
    -- First thing to give up width: the task text, not the branch or the file.
    "%<",
    seg("StatusLineSep", "task_sep"),
    seg("StatusLine", "task"),
    "%=",
    -- right: what am I looking at
    "%#StatusLineFile# ",
    seg("StatusLineFile", "file_name"),
    seg("StatusLineMod", "file_mod"),
    seg("StatusLineSep", "ft_sep"),
    seg(icon_group, "ft_icon"),
    seg("StatusLineDim", "filetype"),
    seg("StatusLineSep", "lsp_sep"),
    "%@v:lua.Statusline.lsp_click@",
    seg("StatusLineDim", "lsp_icons"),
    "%X",
    seg("StatusLineSep", "diag_sep"),
    "%@v:lua.Statusline.diag_click@",
    seg("StatusLineError", "diag_error"),
    seg("StatusLineWarn", "diag_warn"),
    seg("StatusLineInfo", "diag_info"),
    seg("StatusLineHint", "diag_hint"),
    "%X",
    "%#StatusLineSep#│ ",
    seg("StatusLineDim", "pos"),
    "%#StatusLine# ",
  })
end

local function apply_spec()
  vim.wo.statusline = build_spec(cur())
end

-- Global default for windows we never visit via an autocmd below (e.g. the
-- first one); apply_spec then overrides it per window with a window-local value.
vim.o.statusline = build_spec(cur())

-- ── wiring ───────────────────────────────────────────────────────────────────
local aug = vim.api.nvim_create_augroup("statusline", { clear = true })

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = aug,
  callback = function(ev)
    diag_count[ev.buf] = nil
    ft_cache[ev.buf] = nil
  end,
})
vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
  group = aug,
  callback = function(ev) diag_count[ev.buf] = vim.diagnostic.count(ev.buf) end,
})
vim.api.nvim_create_autocmd("ModeChanged", {
  group = aug,
  callback = function() paint_mode(vim.v.event.new_mode) end,
})
-- The LSP block is baked into the spec, so anything that can change the set of
-- servers (or which buffer a window shows) has to rebuild it.
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FileType", "LspAttach", "LspDetach" }, {
  group = aug,
  callback = function() apply_spec() end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = aug,
  callback = function()
    apply_highlights()
    paint_mode()
    apply_spec() -- re-evaluate the devicons link after its groups reload
  end,
})

