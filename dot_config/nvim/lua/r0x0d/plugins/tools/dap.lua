-- DAP: Debug Adapter Protocol
local icons = require 'r0x0d.util.icons'

return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'mfussenegger/nvim-dap-python',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
        { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
        { '<F9>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
        { '<F10>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
        { '<F11>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
        { '<F12>', function() require('dap').step_back() end, desc = 'Debug: Step Back' },
        { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle DAP UI' },
        { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
        { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
        { '<leader>dc', function() require('dap').run_to_cursor() end, desc = 'Debug: Run to cursor' },
        { '<leader>dr', function() require('dap').restart() end, desc = 'Debug: Restart' },
        { '<leader>?', function() require('dapui').eval(nil, { enter = true }) end, desc = 'Debug: Eval var under cursor' },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'python',
                'rust',
                'c',
                'zig',
                'cpp',
            },
        }

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            icons = {
                expanded = icons.dap.expanded,
                collapsed = icons.dap.collapsed,
                current_frame = icons.dap.current_frame,
            },
            controls = {
                icons = icons.dap.controls,
            },
        }
    end,
}

