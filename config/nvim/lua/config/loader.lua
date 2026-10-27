-- Tiny on-demand loader for vim.pack plugins.
--
-- vim.pack installs everything but loads nothing by itself on demand, so
-- plugins flagged `data = { lazy = true }` in pack.lua are installed but kept
-- off the runtimepath. A *group* names plugins to :packadd together, a setup
-- function to run once, and the triggers that load it: filetype, event,
-- command (a stub that loads, then re-runs the command), or an explicit
-- loader.load("group") call from a mapping.
local M = {}

local groups = {}

-- Plugins already added to the runtimepath by pack.lua (non-lazy ones)
M.on_rtp = {}
local aug = vim.api.nvim_create_augroup("loader", { clear = true })

local function notify_err(name, err)
  vim.schedule(function()
    vim.notify(("loader: group '%s' failed:\n%s"):format(name, err), vim.log.levels.ERROR)
  end)
end

function M.load(name)
  local g = groups[name]
  if not g then return vim.notify("loader: unknown group " .. name, vim.log.levels.ERROR) end
  if g.loaded then return end
  g.loaded = true
  for _, dep in ipairs(g.requires or {}) do M.load(dep) end
  if g.init then pcall(g.init) end
  for _, p in ipairs(g.plugins or {}) do
    if not M.on_rtp[p] then
      M.on_rtp[p] = true
      local ok, err = pcall(vim.cmd, "packadd " .. p)
      if not ok then notify_err(name, err) end
    end
  end
  if g.setup then
    local ok, err = pcall(g.setup)
    if not ok then notify_err(name, err) end
  end
end

local function stub_command(group, cmd)
  if vim.fn.exists(":" .. cmd) == 2 then return end
  vim.api.nvim_create_user_command(cmd, function(o)
    pcall(vim.api.nvim_del_user_command, cmd)
    M.load(group)
    local c = { cmd = cmd, bang = o.bang, args = o.fargs, mods = o.smods }
    if o.range == 1 then c.range = { o.line1 } elseif o.range == 2 then c.range = { o.line1, o.line2 } end
    local ok, err = pcall(vim.api.nvim_cmd, c, {})
    if not ok then vim.notify(tostring(err), vim.log.levels.ERROR) end
  end, { nargs = "*", bang = true, range = true, desc = "Loads '" .. group .. "' on first use" })
end

---@class loader.Group
---@field plugins? string[]   names passed to :packadd
---@field requires? string[]  groups to load first
---@field init? fun()         runs before :packadd (set vim.g.* here)
---@field setup? fun()        runs once after the plugins are loaded
---@field eager? boolean      load right away (during init.lua)
---@field defer? boolean      load right after startup finishes
---@field ft? string[]        load on these filetypes
---@field event? string[]     load on these events
---@field cond? fun(ev):boolean  extra condition for `event`/`ft` triggers
---@field cmd? string[]       load on first use of these commands
---@param name string
---@param g loader.Group
function M.group(name, g)
  g.name = name
  groups[name] = g

  if g.eager then return M.load(name) end

  if g.defer then
    vim.api.nvim_create_autocmd("VimEnter", {
      group = aug, once = true,
      callback = function() vim.schedule(function() M.load(name) end) end,
    })
  end

  if g.ft then
    vim.api.nvim_create_autocmd("FileType", {
      group = aug, pattern = g.ft,
      callback = function(ev)
        if g.loaded then return end
        M.load(name)
        -- ftplugins/autocmds that the group just added missed this event
        if vim.api.nvim_buf_is_valid(ev.buf) then
          vim.api.nvim_exec_autocmds("FileType", { buffer = ev.buf, modeline = false })
        end
      end,
    })
  end

  if g.event then
    vim.api.nvim_create_autocmd(g.event, {
      group = aug,
      callback = function(ev)
        if g.loaded then return true end
        if g.cond and not g.cond(ev) then return end
        M.load(name)
        return true
      end,
    })
  end

  for _, cmd in ipairs(g.cmd or {}) do stub_command(name, cmd) end
end

-- For :PluginGroups
function M.status()
  local out = {}
  for name, g in pairs(groups) do
    local trig = {}
    if g.eager then table.insert(trig, "eager") end
    if g.defer then table.insert(trig, "after startup") end
    if g.ft then table.insert(trig, "ft=" .. table.concat(g.ft, ",")) end
    if g.event then table.insert(trig, "event=" .. table.concat(g.event, ",")) end
    if g.cmd then table.insert(trig, "cmd=" .. table.concat(g.cmd, ",")) end
    if #trig == 0 then table.insert(trig, "on demand (mapping)") end
    table.insert(out, { name = name, loaded = g.loaded, trigger = table.concat(trig, "  ") })
  end
  table.sort(out, function(a, b)
    if a.loaded ~= b.loaded then return a.loaded end
    return a.name < b.name
  end)
  return out
end

return M
