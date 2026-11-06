-- gh-based PR helpers (Neovim has no built-in :Git)
-- Synchronous (:wait) on purpose: the output is shown immediately and gh is quick
local function gh(args)
  local res = vim.system(vim.list_extend({ "gh" }, args), { text = true }):wait()
  if res.code ~= 0 then
    vim.notify(vim.trim(res.stderr ~= "" and res.stderr or "gh failed"), vim.log.levels.ERROR)
    return nil
  end
  return res.stdout
end

vim.api.nvim_create_user_command("Pr", function(opts)
  local args = { "pr", "view" }
  if opts.args ~= "" then table.insert(args, opts.args) end
  local out = gh(args)
  if not out then return end
  vim.cmd("botright new")
  vim.bo.buftype, vim.bo.bufhidden, vim.bo.swapfile = "nofile", "wipe", false
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(out, "\n"))
  vim.bo.modifiable = false
end, { nargs = "?", desc = "Show PR (current branch, or number)" })

vim.api.nvim_create_user_command("PrDiff", function(opts)
  local args = { "pr", "diff" }
  if opts.args ~= "" then table.insert(args, opts.args) end
  local out = gh(args)
  if not out then return end
  vim.cmd("tabnew")
  vim.bo.buftype, vim.bo.bufhidden, vim.bo.swapfile = "nofile", "wipe", false
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(out, "\n"))
  vim.bo.filetype = "diff"
  vim.bo.modifiable = false
end, { nargs = "?", desc = "Show PR diff (current branch, or number)" })

-- vim.pack helpers. confirm=false in pack.lua only affects add(); update()
-- still opens its review buffer. offline=true skips the fetch.
vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Review and apply plugin updates (vim.pack)" })

vim.api.nvim_create_user_command("PackStatus", function()
  vim.pack.update(nil, { offline = true })
end, { desc = "Show plugin state without fetching (vim.pack)" })

-- What is loaded, and what would load the rest
vim.api.nvim_create_user_command("PluginGroups", function()
  local lines = { "loaded  group           trigger", "------  --------------  -------" }
  for _, g in ipairs(require("config.loader").status()) do
    table.insert(lines, ("%-6s  %-14s  %s"):format(g.loaded and "yes" or "-", g.name, g.trigger))
  end
  vim.cmd("botright new")
  vim.bo.buftype, vim.bo.bufhidden, vim.bo.swapfile = "nofile", "wipe", false
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.modifiable = false
end, { desc = "Show plugin groups and whether they are loaded" })

-- Startup guard: re-runs a headless startup with --startuptime and lists the
-- biggest self-times, so a plugin that slows startup shows up right after it
-- is added. Headless excludes UI attach and the dashboard, so the total is
-- lower than the "startup" figure on the dashboard (time-to-UI); compare the
-- entries between runs rather than that total against it.
vim.api.nvim_create_user_command("StartupTime", function(opts)
  local top = tonumber(opts.args) or 15
  local log = vim.fn.tempname()
  local res = vim.system({ vim.v.progpath, "--headless", "--startuptime", log, "+qa" }, { text = true, stdin = "" }):wait(10000)
  if res.code ~= 0 or vim.fn.filereadable(log) == 0 then
    vim.notify("startuptime run failed", vim.log.levels.ERROR)
    return
  end
  local entries, total = {}, 0
  for line in io.lines(log) do
    -- "clock  elapsed  self: what" (sourced files) or "clock  elapsed: what" (phases)
    local clock, self, what = line:match("^%s*(%d+%.%d+)%s+%d+%.%d+%s+(%d+%.%d+):%s+(.*)$")
    if not clock then
      clock, what = line:match("^%s*(%d+%.%d+)%s+%d+%.%d+:%s+(.*)$")
      self = nil
    end
    if clock then
      total = tonumber(clock)
      if self then entries[#entries + 1] = { ms = tonumber(self), what = what } end
    end
  end
  vim.fn.delete(log)
  table.sort(entries, function(a, b) return a.ms > b.ms end)

  local lines = {
    ("headless startup: %.0fms   (dashboard time-to-UI: %s)"):format(
      total, vim.g.startup_ms and ("%.0fms"):format(vim.g.startup_ms) or "n/a"),
    "",
    "   self ms  what",
    "   -------  ----",
  }
  for i = 1, math.min(top, #entries) do
    lines[#lines + 1] = ("   %7.2f  %s"):format(entries[i].ms, (entries[i].what:gsub(vim.env.HOME, "~")))
  end
  vim.cmd("botright new")
  vim.bo.buftype, vim.bo.bufhidden, vim.bo.swapfile = "nofile", "wipe", false
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.modifiable = false
end, { nargs = "?", desc = "Profile a headless startup: slowest entries (arg: how many)" })
