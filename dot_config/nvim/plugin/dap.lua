local add_on_event = require('vim-pack').add_on_event

-- Debug Adapter Protocol (available for all filetypes).
add_on_event('UIEnter', {
    {
        src = 'mfussenegger/nvim-dap',
        module_name = 'dap',
        setup = false,
        on_setup = function()
            local dap = require('dap')

            -- Rust/C/C++ via codelldb
            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'codelldb',
                    args = { '--port', '${port}' },
                },
            }
            dap.configurations.rust = {
                {
                    name = 'Launch',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }

            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
            vim.keymap.set('n', '<leader>dB', function()
                dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end, { desc = 'Conditional breakpoint' })
            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
            vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step into' })
            vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step over' })
            vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step out' })
            vim.keymap.set('n', '<leader>dr', dap.restart, { desc = 'Restart' })
            vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Terminate' })
        end,
    },
    {
        src = 'mfussenegger/nvim-dap-python',
        module_name = 'dap-python',
        setup = false,
        on_setup = function()
            require('dap-python').setup(vim.fn.exepath('python'))
        end,
    },
    {
        src = 'nvim-neotest/nvim-nio',
        module_name = 'nio',
        setup = false,
    },
    {
        src = 'rcarriga/nvim-dap-ui',
        module_name = 'dapui',
        on_setup = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end

            vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle DAP UI' })
        end,
    },
})
