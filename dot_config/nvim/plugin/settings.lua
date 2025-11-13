local arrows = require('icons').arrows

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use an indentation of 4 spaces.
vim.o.sw = 4
vim.o.ts = 4
vim.o.et = true

-- Show whitespace.
vim.opt.list = true
vim.opt.listchars = { space = '⋅', trail = '⋅', tab = '  ↦' }

-- Make line numbers default
vim.wo.number = true
vim.opt.background = 'dark'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

vim.opt.colorcolumn = '80'
vim.opt.virtualedit = 'block'

-- Disable horizontal scrolling.
vim.o.mousescroll = 'ver:3,hor:0'

-- Wrap long lines at words.
vim.o.linebreak = true

-- Folding.
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''

-- UI characters.
-- vim.opt.fillchars = {
--     eob = ' ',
--     fold = ' ',
--     foldclose = arrows.right,
--     foldopen = arrows.down,
--     foldsep = ' ',
--     foldinner = ' ',
--     msgsep = '─',
-- }

-- Use rounded borders for floating windows.
vim.o.winborder = 'rounded'

-- Sync clipboard between the OS and Neovim.
if not vim.env.SSH_CLIENT and not vim.env.SSH_TTY then
  vim.o.clipboard = 'unnamedplus'
end

-- Use OSC 52 for SSH sessions to support clipboard sync through terminal
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52 terminal clipboard',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
end

-- Save undo history.
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or the search has capitals.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default.
vim.wo.signcolumn = 'yes'

-- Update times and timeouts.
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- Completion.
vim.opt.wildignore:append { '.DS_Store' }
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.pumheight = 15

-- Diff mode settings.
-- Setting the context to a very large number disables folding.
vim.opt.diffopt:append 'vertical,context:99'

vim.opt.shortmess:append {
    w = true,
    s = true,
}

-- Status line.
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- Disable cursor blinking in terminal mode.
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor'

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- vim: ts=2 sts=2 sw=2 et
