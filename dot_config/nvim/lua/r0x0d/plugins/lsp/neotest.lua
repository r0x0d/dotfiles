return {
  'nvim-neotest/neotest',
  lazy = true,
  cmd = { 'Neotest' }, -- Load when command is run
  keys = {
    { '<leader>tn', desc = 'Run [T]est [N]earest' },
    { '<leader>tf', desc = '[T]est [F]ile' },
    { '<leader>ts', desc = '[T]est [S]top' },
    { '<leader>ta', desc = '[T]est [A]ttach to nearest' },
    { '<leader>tnd', desc = 'Run [T]est [N]earest [D]ebugger' },
  },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          pytest_discover_instances = true,
        },
      },
    }
  end,
}
