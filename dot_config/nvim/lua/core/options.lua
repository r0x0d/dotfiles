vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Toggle states (non-intrusive features start OFF)
vim.g.autoformat_enabled = false
vim.g.lint_enabled = false
vim.g.diagnostics_visible = true
vim.g.inlay_hints_enabled = false

-- Appearance
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.showmode = false

-- Tabs / indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- System
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.undofile = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
