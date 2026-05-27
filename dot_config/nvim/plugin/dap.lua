-- Install but don't load until needed
vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/mfussenegger/nvim-dap-python",
}, { load = function() end })

local loaded = false

local function ensure_dap()
    if loaded then return end
    loaded = true

    vim.cmd.packadd("nvim-nio")
    vim.cmd.packadd("nvim-dap")
    vim.cmd.packadd("nvim-dap-ui")
    vim.cmd.packadd("nvim-dap-python")

    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    require("dap-python").setup("python")
end

vim.keymap.set("n", "<leader>db", function() ensure_dap(); require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function() ensure_dap(); require("dap").continue() end, { desc = "Continue / start" })
vim.keymap.set("n", "<leader>di", function() ensure_dap(); require("dap").step_into() end, { desc = "Step into" })
vim.keymap.set("n", "<leader>do", function() ensure_dap(); require("dap").step_over() end, { desc = "Step over" })
vim.keymap.set("n", "<leader>dO", function() ensure_dap(); require("dap").step_out() end, { desc = "Step out" })
vim.keymap.set("n", "<leader>dr", function() ensure_dap(); require("dap").run_to_cursor() end, { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>dl", function() ensure_dap(); require("dap").run_last() end, { desc = "Run last" })
vim.keymap.set("n", "<leader>dB", function()
    ensure_dap()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<leader>du", function() ensure_dap(); require("dapui").toggle() end, { desc = "Toggle DAP UI" })
