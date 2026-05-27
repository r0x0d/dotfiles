local add = require('vim-pack').add

-- Fuzzy finder.
add {
    { src = 'nvim-lua/plenary.nvim', setup = false },
    {
        src = 'nvim-telescope/telescope.nvim',
        on_setup = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
            vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume search' })
            vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Document symbols' })
            vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Grep word under cursor' })
        end,
    },
}
