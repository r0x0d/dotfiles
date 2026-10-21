local mason = vim.fn.stdpath("data") .. "/mason/packages/"

local dap, dapui = require("dap"), require("dapui")
dapui.setup()
require("nvim-dap-virtual-text").setup()
-- debugpy comes from mason's venv, not the system python
require("dap-python").setup(mason .. "debugpy/venv/bin/python")

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Rust is handled by rustaceanvim (uses mason's codelldb automatically);
-- this is for plain C/C++.
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = { command = "codelldb", args = { "--port", "${port}" } },
}
local native = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
}
dap.configurations.c = native
dap.configurations.cpp = native
