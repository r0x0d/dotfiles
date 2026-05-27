local add_on_event = require('vim-pack').add_on_event

-- Highlight and navigate TODO/FIXME/HACK comments.
add_on_event({ 'BufReadPre', 'BufNewFile' }, {
    {
        src = 'folke/todo-comments.nvim',
        on_setup = function()
            vim.keymap.set('n', ']t', function()
                require('todo-comments').jump_next()
            end, { desc = 'Next TODO comment' })
            vim.keymap.set('n', '[t', function()
                require('todo-comments').jump_prev()
            end, { desc = 'Previous TODO comment' })
        end,
    },
})
