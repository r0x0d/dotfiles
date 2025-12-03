-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set projects and work projects dir
vim.g.projects_dir = vim.env.HOME .. "/Workspace"
vim.g.work_projects_dir = vim.env.HOME .. "/Workspace"

-- Install lazynvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp = vim.opt.rtp ^ lazypath

-- Configure plugins.
require('lazy').setup("plugins", {
    ui = { border = 'rounded' },
    dev = { path = vim.g.projects_dir },
    install = {
        -- Do not automatically install on startup.
        missing = false,
    },
    -- Don't bother me when tweaking plugins.
    change_detection = { notify = false },
    -- None of my plugins use luarocks so disable this.
    rocks = {
        enabled = false,
    },
    performance = {
        rtp = {
            -- Stuff I don't use.
            disabled_plugins = {
                'gzip',
                'tarPlugin',
                'zipPlugin',
                'netrwPlugin',
                'rplugin',
                'tohtml',
                'tutor',
            },
        },
    },
})

vim.cmd.colorscheme '3024'
