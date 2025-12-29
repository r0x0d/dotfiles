-- Which-key: Keybinding hints
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        spec = {
            { '<leader>f', group = 'find' },
            { '<leader>g', group = 'git' },
            { '<leader>t', group = 'test' },
            { '<leader>c', group = 'code' },
            { '<leader>d', group = 'delete/debug' },
        },
    },
}

