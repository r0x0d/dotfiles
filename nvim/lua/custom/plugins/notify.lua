return {
  {
    'rcarriga/nvim-notify',
    name = 'notify',
    init = function(plugin)
      vim.notify = require(plugin.name)
    end,
    config = function()
      require('notify').setup {
        background_colour = '#000000',
      }
    end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}

