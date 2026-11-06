local function short(path) return vim.fn.fnamemodify(path, ":~") end

-- Unique git roots of recently opened files
local function project_roots(limit)
  local seen, roots = {}, {}
  for _, f in ipairs(vim.v.oldfiles) do
    if vim.uv.fs_stat(f) then
      local root = vim.fs.root(f, ".git")
      if root and not seen[root] then
        seen[root] = true
        table.insert(roots, root)
        if #roots >= limit then break end
      end
    end
  end
  return roots
end

-- persistence.nvim names session files after the directory with path separators
-- (and ':') replaced by '%', so rebuild that name to find a project's session.
local function session_file_for(dir)
  local name = dir:gsub("[\\/:]+", "%%")
  local dirpath = vim.fn.stdpath("state") .. "/sessions/"
  for _, f in ipairs({ dirpath .. name .. ".vim" }) do
    if vim.fn.filereadable(f) == 1 then return f end
  end
end

local function projects_section()
  local items = {}
  for _, root in ipairs(project_roots(5)) do
    table.insert(items, {
      name = short(root),
      section = "Projects",
      action = function()
        vim.cmd.cd(vim.fn.fnameescape(root))
        local sess = session_file_for(root)
        if sess then
          vim.cmd("silent! source " .. vim.fn.fnameescape(sess))
        else
          vim.cmd("Telescope find_files")
        end
      end,
    })
  end
  return items
end

local function sessions_section()
  local ok, persistence = pcall(require, "persistence")
  if not ok then return {} end
  local items = {}
  for i, file in ipairs(persistence.list()) do
    if i > 5 then break end
    local base = vim.fn.fnamemodify(file, ":t:r")
    local dir, branch = base:match("^(.-)%%%%(.*)$")
    dir = (dir or base):gsub("%%", "/")
    local label = short(dir) .. (branch and ("  (" .. branch:gsub("%%", "/") .. ")") or "")
    table.insert(items, {
      name = label,
      section = "Sessions",
      action = function() vim.cmd("silent! source " .. vim.fn.fnameescape(file)) end,
    })
  end
  return items
end

-- Recent files. Long names are clamped by the layout hook, which is the only
-- place that knows the final column width.
local function recent_section()
  local cwd = vim.fn.getcwd()
  local in_repo = vim.fs.root(cwd, ".git") ~= nil
  local items
  if in_repo then
    items = require("mini.starter").sections.recent_files(6, true, false)()
  else
    -- Outside a project, recent files come from anywhere. mini.starter's
    -- default suffix (the file's full path) is unbounded, so use the file's
    -- git root (or parent dir) as compact context instead.
    items = require("mini.starter").sections.recent_files(6, false, function(path)
      local root = vim.fs.root(path, ".git")
      local ctx = vim.fn.fnamemodify(root or path, root and ":~" or ":~:h")
      return " (" .. ctx .. ")"
    end)()
  end
  -- mini.starter returns a placeholder item when nothing matches; hide the section
  if #items == 1 and items[1].name:match("^There are no") then return {} end
  return items
end

-- Git status is read off the startup path: the footer draws without it and the
-- dashboard refreshes once the (async) answer lands. A synchronous `git status`
-- costs ~10ms here and far more in a big repo, all of it counted in time-to-UI.
-- Later fetches (FocusGained, reopening the dashboard) keep showing the previous
-- value until the new one arrives, so the row never flickers away.
local git_cache = nil -- nil = never fetched, false = not a repo / failed, table = { branch, dirty }
local git_pending = false

local function git_fetch()
  if git_pending then return end
  local cwd = vim.fn.getcwd()
  if not vim.fs.root(cwd, ".git") then
    git_cache = false
    return
  end
  git_pending = true
  vim.system({ "git", "status", "--porcelain", "--branch" }, { text = true, cwd = cwd }, function(r)
    vim.schedule(function()
      git_pending = false
      local new = false
      if r.code == 0 then
        local lines = vim.split(vim.trim(r.stdout), "\n")
        local head = (lines[1] or ""):match("^## (.-)%.%.%.") or (lines[1] or ""):match("^## (%S+)")
        if head then new = { branch = head, dirty = #lines - 1 } end
      end
      -- Only redraw when something changed: refresh() re-evaluates the footer,
      -- and an unconditional one would be wasted work on every focus event.
      if not vim.deep_equal(new, git_cache) then
        git_cache = new
        local ok, starter = pcall(require, "mini.starter")
        if ok and vim.bo.filetype == "ministarter" then starter.refresh() end
      end
    end)
  end)
end

local function git_status()
  if git_cache == nil then git_fetch() end
  if git_cache then return git_cache.branch, git_cache.dirty end
end

-- Only the values that carry a verdict are coloured (startup time, git state);
-- the box itself stays neutral. footer() records which text gets which group in
-- `marks`, and boxed() splits the footer lines around them. This ordering
-- matters: the content hooks run after footer() has been evaluated.
-- default = true lets a colorscheme override these groups.
local STARTUP_WARN_MS, STARTUP_BAD_MS = 150, 300
local marks = {} -- { { label = "⚡ startup", value = "87ms", group = "DashboardStatusOk" } }
for name, link in pairs({ Ok = "DiagnosticOk", Warn = "DiagnosticWarn", Bad = "DiagnosticError" }) do
  vim.api.nvim_set_hl(0, "DashboardStatus" .. name, { link = link, default = true })
end

-- Footer: a centred "Status" box of label/value pairs, two per row. The lines
-- all share one display width, so the centring in boxed() keeps it aligned.
local function footer()
  local dw = vim.fn.strdisplaywidth
  local function rpad(s, w) return s .. string.rep(" ", math.max(w - dw(s), 0)) end

  local v = vim.version()
  local cells = { { "🛸 nvim", ("%d.%d.%d"):format(v.major, v.minor, v.patch) } }
  local okv, plugs = pcall(vim.pack.get, nil, { info = false })
  if okv then
    local rtp, loaded = {}, 0
    for _, r in ipairs(vim.api.nvim_list_runtime_paths()) do rtp[r] = true end
    for _, p in ipairs(plugs) do
      if rtp[p.path] then loaded = loaded + 1 end
    end
    table.insert(cells, { "📦 plugins", ("%d/%d"):format(loaded, #plugs) })
  end
  if vim.g.startup_ms then
    table.insert(cells, { "⚡ startup", ("%.0fms"):format(vim.g.startup_ms) })
  end
  table.insert(cells, { "🕘 recent", tostring(#vim.v.oldfiles) })
  local okp, persistence = pcall(require, "persistence")
  if okp then table.insert(cells, { "📂 sessions", tostring(#persistence.list()) }) end
  marks = {}
  if vim.g.startup_ms then
    local ms = vim.g.startup_ms
    marks[#marks + 1] = {
      label = "⚡ startup", value = ("%.0fms"):format(ms),
      group = ms > STARTUP_BAD_MS and "DashboardStatusBad"
        or ms > STARTUP_WARN_MS and "DashboardStatusWarn" or "DashboardStatusOk",
    }
  end
  local branch, dirty = git_status()
  if branch then
    local state = dirty > 0 and ("🍂 " .. dirty) or "🌱"
    if #branch > 18 then branch = vim.fn.strcharpart(branch, 0, 17) .. "…" end
    local value = branch .. " " .. state
    table.insert(cells, { "🌿 branch", value })
    marks[#marks + 1] = {
      label = "🌿 branch", value = value,
      group = dirty > 0 and "DashboardStatusWarn" or "DashboardStatusOk",
    }
  end

  -- Column-wise widths so labels and values line up across rows.
  local lw, vw = { 0, 0 }, { 0, 0 }
  for i, c in ipairs(cells) do
    local col = (i - 1) % 2 + 1
    lw[col] = math.max(lw[col], dw(c[1]))
    vw[col] = math.max(vw[col], dw(c[2]))
  end
  local rows = {}
  for i = 1, #cells, 2 do
    local parts = {}
    for j = i, math.min(i + 1, #cells) do
      local col = (j - i) + 1
      parts[#parts + 1] = rpad(cells[j][1], lw[col]) .. "  " .. rpad(cells[j][2], vw[col])
    end
    rows[#rows + 1] = table.concat(parts, "    ")
  end

  local inner = 0
  for _, r in ipairs(rows) do inner = math.max(inner, dw(r)) end
  inner = math.max(inner, 12) + 2
  local title = " Status "
  local lines = { "╭─" .. title .. string.rep("─", inner - dw(title) - 1) .. "╮" }
  for _, r in ipairs(rows) do lines[#lines + 1] = "│ " .. rpad(r, inner - 2) .. " │" end
  lines[#lines + 1] = "╰" .. string.rep("─", inner) .. "╯"
  return table.concat(lines, "\n")
end

local function header()
  return table.concat({
    "🛸  N E O V I M",
    "",
    short(vim.fn.getcwd()) .. "   ·   " .. os.date("%A, %d %B %Y"),
  }, "\n")
end

-- Layout ----------------------------------------------------------------------
-- mini.starter draws one item per line by default, but its content model does
-- not require it: content_to_items() walks every unit of every line and records
-- a start/end column and a cursor position per item. Items can therefore sit
-- side by side, each with its own highlight and cursor target. Query filtering
-- dims hidden items instead of dropping lines, so the grid stays put while
-- typing -- which is what makes a hand-rolled box layout viable at all.

local function width(s) return vim.fn.strdisplaywidth(s) end

local function units_width(units)
  local w = 0
  for _, u in ipairs(units) do w = w + width(u.string) end
  return w
end

local function pad(n) return { string = string.rep(" ", math.max(n, 0)), type = "empty" } end

local function blank() return { string = "", type = "empty" } end

-- Middle-truncate so no item can blow out its box. mini.starter centers every
-- line around the widest one, so a single over-wide entry pushes the whole
-- dashboard against the left edge.
local function fit(s, maxw)
  if width(s) <= maxw then return s end
  local head_n = math.floor(maxw / 2) - 1
  local tail_n = math.max(maxw - head_n - 1, 0)
  return vim.fn.strcharpart(s, 0, head_n) .. "…" .. vim.fn.strcharpart(s, math.max(vim.fn.strchars(s) - tail_n, 0))
end

-- Shallow copy: truncation must not leak into the shared item tables, and the
-- bullet unit's `_item` back-reference has to keep pointing at the real item.
local function copy_line(line)
  local out = {}
  for i, u in ipairs(line) do out[i] = vim.tbl_extend("force", {}, u) end
  return out
end

local function shrink(line, maxw)
  local total = units_width(line)
  if total <= maxw then return line end
  for i = #line, 1, -1 do
    local u = line[i]
    if u.type == "item" then
      u.string = fit(u.string, math.max(maxw - (total - width(u.string)), 4))
      break
    end
  end
  return line
end

-- Section prefixes for the item index (s1, s2 ... r1 ... p1). mini.starter's
-- own indexing() hands out a, b, c by order of appearance in the content,
-- which tells you nothing about which box -- or which kind of entry -- you are
-- looking at. Actions stay unnumbered on purpose.
local function index_prefix(section)
  if section == "Sessions" then return "s" end
  if section == "Projects" then return "p" end
  if section:match("^Recent") then return "r" end
end

local function indexed(content)
  local counts = {}
  for _, coord in ipairs(require("mini.starter").content_coords(content, "item")) do
    local unit = content[coord.line][coord.unit]
    local prefix = index_prefix(unit.item.section)
    if prefix then
      counts[prefix] = (counts[prefix] or 0) + 1
      unit.string = ("%s%d. %s"):format(prefix, counts[prefix], unit.string)
    end
  end
  return content
end

-- Split the flat content from make_initial_content() into header, footer and
-- per-section blocks. Section labels and blank separator lines are dropped;
-- the box renderer draws its own.
local function split_content(content)
  local header, footer, groups = {}, {}, {}
  local current
  for _, line in ipairs(content) do
    local kind
    for _, u in ipairs(line) do
      if u.type == "item" or u.type == "item_bullet" then kind = "item" break end
      if u.type == "section" then kind = "section" break end
      if u.type == "header" then kind = "header" break end
      if u.type == "footer" then kind = "footer" break end
    end
    if kind == "header" then
      header[#header + 1] = line
    elseif kind == "footer" then
      footer[#footer + 1] = line
    elseif kind == "section" then
      local name
      for _, u in ipairs(line) do
        if u.type == "section" then name = u.string break end
      end
      -- mini.starter renames this section when cwd is inside a repo
      if name and name:match("^Recent files") then name = "Recent files" end
      current = { name = name, lines = {} }
      groups[#groups + 1] = current
    elseif kind == "item" and current then
      current.lines[#current.lines + 1] = line
    end
  end
  return header, groups, footer
end

-- Which section goes in which box and column. Sessions and Recent share the
-- left box; Actions and Projects get a box each on the right.
local BOXES = {
  { column = 1, sections = { "Sessions", "Recent files" }, title = "Sessions & Recent" },
  { column = 2, sections = { "Actions" } },
  { column = 2, sections = { "Projects" } },
}

-- Build the inside of a box. Returns nil when none of its sections has items,
-- so empty boxes (no sessions yet, no git roots) disappear entirely.
local function box_body(box, by_name, inner_w)
  local present = {}
  for _, name in ipairs(box.sections) do
    local g = by_name[name]
    if g and #g.lines > 0 then present[#present + 1] = { name = name, lines = g.lines } end
  end
  if #present == 0 then return nil end

  local body = {}
  for _, sec in ipairs(present) do
    if #body > 0 then body[#body + 1] = { blank() } end
    if #present > 1 then
      local label = sec.name:gsub(" files$", ""):upper()
      body[#body + 1] = { { string = label, type = "section", hl = "MiniStarterSection" } }
    end
    for _, line in ipairs(sec.lines) do
      body[#body + 1] = shrink(copy_line(line), inner_w - 2)
    end
  end

  local title = box.title
  if not title then
    title = table.concat(vim.tbl_map(function(s) return s.name:gsub(" files$", "") end, present), " & ")
  end
  return title, body
end

local function render_box(title, body, inner_w)
  local t = fit(title, math.max(inner_w - 3, 1))
  local fill = math.max(inner_w - width(t) - 3, 0)
  local out = {
    {
      { string = "╭─ ", type = "empty", hl = "MiniStarterSection" },
      { string = t, type = "section", hl = "MiniStarterSection" },
      { string = " " .. string.rep("─", fill) .. "╮", type = "empty", hl = "MiniStarterSection" },
    },
  }
  for _, units in ipairs(body) do
    local line = {
      { string = "│", type = "empty", hl = "MiniStarterSection" },
      pad(1),
    }
    vim.list_extend(line, units)
    line[#line + 1] = pad(inner_w - 1 - units_width(units))
    line[#line + 1] = { string = "│", type = "empty", hl = "MiniStarterSection" }
    out[#out + 1] = line
  end
  out[#out + 1] = { { string = "╰" .. string.rep("─", inner_w) .. "╯", type = "empty", hl = "MiniStarterSection" } }
  return out
end

-- Final content hook: lays the flat mini.starter content out as two columns of
-- boxes, then adds header, footer and vertical centring.
local function boxed(content, buf_id)
  local win = vim.fn.bufwinid(buf_id)
  local win_w = win > 0 and vim.api.nvim_win_get_width(win) or vim.o.columns
  local win_h = win > 0 and vim.api.nvim_win_get_height(win) or (vim.o.lines - 2)

  local head, groups, foot = split_content(content)
  local by_name = {}
  for _, g in ipairs(groups) do by_name[g.name] = g end

  local gap = 2
  local col_w = math.min(math.max(math.floor((win_w - gap) / 2), 28), 64)
  local inner_w = col_w - 2

  -- Render the boxes per column first, so the two columns can be equalized:
  -- the shorter one gets blank rows inside its last box, which lines the
  -- bottom borders up with the taller column.
  local cols = { {}, {} }
  for _, box in ipairs(BOXES) do
    local title, body = box_body(box, by_name, inner_w)
    if title then
      local col = cols[box.column]
      col[#col + 1] = { lines = render_box(title, body, inner_w) }
    end
  end

  local function col_height(col)
    local h = 0
    for _, b in ipairs(col) do h = h + #b.lines end
    return h + math.max(#col - 1, 0) -- one blank line between stacked boxes
  end

  local shorter = col_height(cols[1]) < col_height(cols[2]) and 1 or 2
  local taller = shorter == 1 and 2 or 1
  local last = cols[shorter][#cols[shorter]]
  local extra = col_height(cols[taller]) - col_height(cols[shorter])
  if last then
    for _ = 1, extra do
      table.insert(last.lines, #last.lines, {
        { string = "│", type = "empty", hl = "MiniStarterSection" },
        pad(inner_w),
        { string = "│", type = "empty", hl = "MiniStarterSection" },
      })
    end
  end

  local flat = { {}, {} }
  for c = 1, 2 do
    for i, b in ipairs(cols[c]) do
      if i > 1 then flat[c][#flat[c] + 1] = { blank() } end
      vim.list_extend(flat[c], b.lines)
    end
  end

  local grid = {}
  for i = 1, math.max(#flat[1], #flat[2]) do
    local left_cell, right_cell = flat[1][i], flat[2][i]
    local has_left = left_cell ~= nil and units_width(left_cell) > 0
    local has_right = right_cell ~= nil and units_width(right_cell) > 0
    local line = {}
    if has_left then
      vim.list_extend(line, left_cell)
      if has_right then line[#line + 1] = pad(gap) end
    elseif has_right then
      line[#line + 1] = pad(col_w + gap) -- keep the right box on its column
    end
    if has_right then vim.list_extend(line, right_cell) end
    grid[i] = line
  end

  local out = {}
  -- Splits a footer line into units so each marked value gets its own group.
  -- The label is located first so "87ms" can't match anywhere else in the row.
  local function paint(line)
    local units = copy_line(line)
    if #units ~= 1 then return units end
    local str = units[1].string
    local hits = {}
    for _, m in ipairs(marks) do
      local ls, le = str:find(m.label, 1, true)
      local vs, ve = nil, nil
      if ls then vs, ve = str:find(m.value, le + 1, true) end
      if vs then hits[#hits + 1] = { vs, ve, m.group } end
    end
    if #hits == 0 then return units end
    table.sort(hits, function(a, b) return a[1] < b[1] end)
    local out_units, pos = {}, 1
    for _, h in ipairs(hits) do
      if h[1] > pos then out_units[#out_units + 1] = { string = str:sub(pos, h[1] - 1), type = "footer", hl = "MiniStarterFooter" } end
      out_units[#out_units + 1] = { string = str:sub(h[1], h[2]), type = "footer", hl = h[3] }
      pos = h[2] + 1
    end
    if pos <= #str then out_units[#out_units + 1] = { string = str:sub(pos), type = "footer", hl = "MiniStarterFooter" } end
    return out_units
  end

  local function add_centered(line, painted)
    if units_width(line) == 0 then
      out[#out + 1] = { blank() }
      return
    end
    local padded = { pad(math.max(math.floor((win_w - units_width(line)) / 2), 0)) }
    out[#out + 1] = vim.list_extend(padded, painted and paint(line) or copy_line(line))
  end

  for _, line in ipairs(head) do add_centered(line) end
  if #head > 0 then out[#out + 1] = { blank() } end

  local left = math.max(math.floor((win_w - (col_w * 2 + gap)) / 2), 0)
  for _, line in ipairs(grid) do
    out[#out + 1] = vim.list_extend({ pad(left) }, line)
  end

  if #foot > 0 then
    out[#out + 1] = { blank() }
    for _, line in ipairs(foot) do add_centered(line, true) end
  end

  for _ = 1, math.max(math.floor((win_h - #out) / 2), 0) do
    table.insert(out, 1, { blank() })
  end

  return out
end

local starter = require("mini.starter")
starter.setup({
  header = header,
  footer = footer,
  evaluate_single = true,
  -- No "-": it must stay free for oil's "go to parent directory" mapping
  query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
  items = {
    sessions_section,
    projects_section,
    recent_section,
    {
      { name = "Find file", action = "Telescope find_files", section = "Actions" },
      { name = "Grep", action = "Telescope live_grep", section = "Actions" },
      { name = "Explorer", action = "Oil", section = "Actions" },
      { name = "New file", action = "enew | startinsert", section = "Actions" },
      { name = "Update plugins", action = "PackUpdate", section = "Actions" },
      { name = "Mason", action = "Mason", section = "Actions" },
      { name = "Help cheatsheet", action = "help myconfig", section = "Actions" },
      { name = "Quit", action = "qa", section = "Actions" },
    },
  },
  content_hooks = {
    -- Order matters: indexed() needs the bullet units, and boxed() must run
    -- last since it re-flows everything into the grid.
    starter.gen_hook.adding_bullet("» "),
    indexed,
    boxed,
  },
})

-- Time-to-UI is only known once the UI is up, so redraw the footer then
vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    vim.g.startup_ms = (vim.uv.hrtime() - vim.g.nvim_start) / 1e6
    if vim.bo.filetype == "ministarter" then starter.refresh() end
  end,
})

-- A grid row holds two items, so up/down should move by a row and keep the
-- column. The public API only steps item by item (reading order), so walk the
-- list until the cursor leaves the current line and lands in the same box --
-- items of one column share a start column. If no such item exists (bottom of
-- a column, or the other box ended earlier), step back and stay put.
local function move_row(dir)
  local buf = vim.api.nvim_get_current_buf()
  local items = starter.content_to_items()
  local function item_at_cursor()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    for _, it in ipairs(items) do
      if it._cursorpos[1] == row and it._cursorpos[2] == col then return it end
    end
  end

  local ref = item_at_cursor()
  if not ref then return end

  local steps = 0
  for _ = 1, #items do
    local before = vim.api.nvim_win_get_cursor(0)
    starter.update_current_item(dir, buf)
    local now = vim.api.nvim_win_get_cursor(0)
    if now[1] == before[1] and now[2] == before[2] then break end -- end of list

    steps = steps + 1
    local it = item_at_cursor()
    -- Columns are a full box width apart, so a small delta means same column.
    if it and it._line ~= ref._line and math.abs(it._start_col - ref._start_col) < 12 then return end
  end

  for _ = 1, steps do
    starter.update_current_item(dir == "next" and "prev" or "next", buf)
  end
end

-- A commit made elsewhere (lazygit, another terminal) is picked up on return.
vim.api.nvim_create_autocmd("FocusGained", { callback = git_fetch })

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniStarterOpened",
  callback = function(ev)
    git_fetch() -- the dashboard may be reopened long after the first fetch
    local buf = (ev.buf and ev.buf > 0) and ev.buf or vim.api.nvim_get_current_buf()
    local set = function(lhs, fn)
      vim.keymap.set("n", lhs, fn, { buffer = buf, nowait = true, silent = true })
    end
    local down = function() move_row("next") end
    local up = function() move_row("prev") end
    for _, key in ipairs({ "<Down>", "<M-j>" }) do set(key, down) end
    for _, key in ipairs({ "<Up>", "<M-k>" }) do set(key, up) end
    set("<Right>", function() starter.update_current_item("next", buf) end)
    set("<Left>", function() starter.update_current_item("prev", buf) end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ministarter",
  callback = function()
    vim.wo.number, vim.wo.relativenumber = false, false
    vim.wo.colorcolumn, vim.wo.cursorline = "", false
    vim.wo.signcolumn = "no"
  end,
})
