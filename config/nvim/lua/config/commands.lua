-- gh-based PR helpers (Neovim has no built-in :Git)
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

-- vim.pack helpers
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
