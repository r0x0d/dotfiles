vim.loader.enable() -- byte-code cache for lua modules
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.nvim_start = vim.uv.hrtime() -- the dashboard reports time-to-UI from here

-- Built-in plugins this config never uses (netrw is replaced by oil)
for _, p in ipairs({ "gzip", "tarPlugin", "zipPlugin", "tutor", "rplugin", "netrw", "netrwPlugin" }) do
  vim.g["loaded_" .. p] = 1
end

-- Order matters: options first (groups' eager setups assume them), pack before
-- groups (groups only reference plugins that vim.pack has already installed),
-- and keymaps after groups so loader.load() targets are all registered.
require("config.options")
require("config.pack")

require("config.groups") -- declares what loads when (config/groups.lua)

require("config.keymaps")
require("config.autocmds")
require("config.statusline")
require("config.commands")
