-- Oil: File explorer that lets you edit your filesystem like a buffer
return {
    'stevearc/oil.nvim',
    cmd = { 'Oil' },
    keys = {
        { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
        { '<leader>-', function() require('oil').toggle_float() end, desc = 'Toggle oil floating' },
    },
    config = function()
        require('oil').setup {
            columns = { 'icon' },
            keymaps = {
                ['<C-h>'] = false,
                ['<C-l>'] = false,
                ['<C-k>'] = false,
                ['<C-j>'] = false,
                ['<M-h>'] = 'actions.select_split',
            },
            view_options = {
                show_hidden = true,
            },
        }
    end,
}

