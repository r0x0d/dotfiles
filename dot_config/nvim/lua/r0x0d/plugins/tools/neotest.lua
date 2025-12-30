-- Neotest: Testing framework
return {
    'nvim-neotest/neotest',
    lazy = true,
    ft = { 'python' }, -- Only load for Python since we only have Python adapter
    cmd = { 'Neotest' },
    keys = {
        { '<leader>tn', function() require('neotest').run.run() end, desc = 'Run nearest test' },
        { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Test file' },
        { '<leader>ts', function() require('neotest').run.stop() end, desc = 'Stop test' },
        { '<leader>ta', function() require('neotest').run.attach() end, desc = 'Attach to nearest test' },
        { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Test output' },
        { '<leader>tS', function() require('neotest').summary.toggle() end, desc = 'Test summary' },
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

