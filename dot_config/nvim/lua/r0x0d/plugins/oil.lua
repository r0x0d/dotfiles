return {
  {
    'stevearc/oil.nvim',
    lazy = true,
    cmd = { 'Oil' },
    keys = {
      { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
      { '<space>-', '<CMD>Oil toggle_float<CR>', desc = 'Toggle oil floating' },
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
  },
}
