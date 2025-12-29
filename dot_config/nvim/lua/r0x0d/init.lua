-- r0x0d's Neovim configuration
-- Main entry point that loads all configuration modules

-- Enable Lua module bytecode caching for faster startup
vim.loader.enable()

-- Set leader keys first (must happen before plugins are loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set projects directory
vim.g.projects_dir = vim.env.HOME .. '/Workspace'
vim.g.work_projects_dir = vim.g.projects_dir

-- Load core configuration
require 'r0x0d.options'
require 'r0x0d.keymaps'
require 'r0x0d.autocmds'
require 'r0x0d.commands'
require 'r0x0d.marks'

-- Bootstrap and configure lazy.nvim
require('r0x0d.lazy').setup()

-- Load LSP configuration (after plugins are loaded)
require 'r0x0d.lsp'

-- Set colorscheme
vim.cmd.colorscheme 'catppuccin'

