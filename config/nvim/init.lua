vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.nvim_start = vim.uv.hrtime() -- the dashboard reports time-to-UI from here

-- Built-in plugins this config never uses (netrw is replaced by oil)
for _, p in ipairs({ "gzip", "tarPlugin", "zipPlugin", "tutor", "rplugin", "netrw", "netrwPlugin" }) do
  vim.g["loaded_" .. p] = 1
end

require("config.options")
require("config.pack")

require("config.groups") -- declares what loads when (config/groups.lua)

require("config.keymaps")
require("config.autocmds")
require("config.statusline")
require("config.commands")
