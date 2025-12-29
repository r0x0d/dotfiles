-- Comment.nvim: Code commenting
return {
    'numToStr/Comment.nvim',
    lazy = true,
    event = 'VeryLazy',
    opts = {},
    keys = {
        { 'gcc', mode = { 'n' }, desc = 'Comment toggle current line' },
        { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle' },
        { 'gc', mode = { 'v' }, desc = 'Comment toggle in visual mode' },
    },
}

