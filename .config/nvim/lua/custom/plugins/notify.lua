return {
  'rcarriga/nvim-notify',
  name = 'notify',
  init = function(plugin)
    vim.notify = require(plugin.name)
  end,
  dependencies = { 'nvim-telescope/telescope.nvim' },
}

