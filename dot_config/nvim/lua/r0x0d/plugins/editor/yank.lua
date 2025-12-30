-- Yanky: Better copy/pasting with yank history
-- Works seamlessly both locally and over SSH (via OSC52 in options.lua)
return {
    'gbprod/yanky.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
        ring = {
            history_length = 50,
            storage = 'memory', -- Don't persist across sessions
            sync_with_numbered_registers = true,
        },
        highlight = { timer = 200 },
        system_clipboard = {
            sync_with_ring = true, -- Sync yanks with system clipboard
        },
    },
    keys = {
        { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put after cursor' },
        { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put before cursor' },
        { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put after and leave cursor after' },
        { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put before and leave cursor after' },
        { '=p', '<Plug>(YankyPutAfterLinewise)', desc = 'Put in line below' },
        { '=P', '<Plug>(YankyPutBeforeLinewise)', desc = 'Put in line above' },
        { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle forward through yank history' },
        { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle backward through yank history' },
        { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
        { '<leader>fy', '<cmd>Telescope yank_history<cr>', desc = 'Yank history' },
    },
    config = function(_, opts)
        require('yanky').setup(opts)
        require('telescope').load_extension 'yank_history'
    end,
}

