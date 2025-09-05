return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  config = function()
    local neotest = require 'neotest'

    -- Run nearest test with dap
    vim.keymap.set('n', '<leader>tnd', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Run [T]est [N]earest [D]ebugger' })

    -- Run nearest test
    vim.keymap.set('n', '<leader>tn', function()
      neotest.run.run()
    end, { desc = 'Run [T]est [N]earest' })

    -- Run test file
    vim.keymap.set('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Run [T]est [F]ile' })

    -- Stop test
    vim.keymap.set('n', '<leader>ts', function()
      neotest.run.stop()
    end, { desc = '[T]est [S]top' })

    -- Attach to the nearest test
    vim.keymap.set('n', '<leader>ta', function()
      neotest.run.attach()
    end, { desc = '[T]est [A]ttach to nearest' })

    neotest.setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          pytest_discover_instances = true,
        },
      },
    }
  end,
}
