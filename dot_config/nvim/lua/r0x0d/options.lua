-- Neovim options configuration
local opt = vim.opt

-- Use an indentation of 4 spaces.
vim.o.sw = 4
vim.o.ts = 4
vim.o.et = true

-- Show whitespace.
opt.list = true
opt.listchars = { space = '⋅', trail = '⋅', tab = '  ↦' }

-- Make line numbers default
vim.wo.number = true
opt.background = 'dark'

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

opt.colorcolumn = '80'
opt.virtualedit = 'block'

-- Disable horizontal scrolling.
vim.o.mousescroll = 'ver:3,hor:0'

-- Wrap long lines at words.
vim.o.linebreak = true

-- Folding.
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''

-- Use rounded borders for floating windows.
vim.o.winborder = 'rounded'

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
opt.wildignore:append { '.DS_Store' }
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.pumheight = 15

-- Diff mode settings.
-- Setting the context to a very large number disables folding.
opt.diffopt:append 'vertical,context:99'

opt.shortmess:append {
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

-- Clipboard configuration
-- For SSH sessions, use OSC52 (syncs with local clipboard through terminal)
-- For local sessions, let Neovim auto-detect system clipboard (wl-paste, xclip, etc.)
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
    vim.g.clipboard = {
        name = 'OSC 52',
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
opt.clipboard = 'unnamedplus'

