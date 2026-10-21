vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.nvim_start = vim.uv.hrtime() -- the dashboard reports time-to-UI from here

require("config.options")
require("config.pack")

require("config.groups") -- declares what loads when (config/groups.lua)

require("config.keymaps")
require("config.autocmds")
require("config.lsp") -- defines the server configs; they start when a file opens
require("config.statusline")
require("config.commands")
