-- Lazy.nvim bootstrap and configuration
local M = {}

function M.setup()
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

    require('lazy').setup('r0x0d.plugins', {
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
                    'netrwPlugin',
                    'rplugin',
                    'tohtml',
                    'tutor',
                },
            },
        },
    })
end

return M

