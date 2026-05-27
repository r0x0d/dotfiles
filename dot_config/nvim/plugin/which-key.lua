local add_on_event = require('vim-pack').add_on_event

-- Show pending keybinding hints.
add_on_event('VimEnter', {
    {
        src = 'folke/which-key.nvim',
        opts = {
            delay = 300,
            icons = {
                mappings = false,
            },
        },
    },
})
