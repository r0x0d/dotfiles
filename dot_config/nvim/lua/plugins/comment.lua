return {
  'numToStr/Comment.nvim',
  lazy = true,
  event = 'VeryLazy', -- Load during startup but not immediately
  opts = {},
  keys = {
    { 'gcc', mode = { 'n' }, desc = 'Comment toggle current line' },
    { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle' },
    { 'gc', mode = { 'v' }, desc = 'Comment toggle in visual mode' },
  },
}
