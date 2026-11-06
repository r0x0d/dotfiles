-- mason installs under stdpath("data"); resolved by path because the
-- packages are not on the runtimepath.
local mason = vim.fn.stdpath("data") .. "/mason/packages/"

local dap, dapui = require("dap"), require("dapui")
dapui.setup()
require("nvim-dap-virtual-text").setup()
-- debugpy comes from mason's venv, not the system python
require("dap-python").setup(mason .. "debugpy/venv/bin/python")

-- Auto-open/close dap-ui with the session so the layout follows the debuggee
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Rust is handled by rustaceanvim (uses mason's codelldb automatically);
-- this is for plain C/C++. The bare "codelldb" command resolves through
-- mason's bin dir, which groups.lua puts on PATH at startup.
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = { command = "codelldb", args = { "--port", "${port}" } },
}
-- No default args: the program path is prompted for, since C/C++ projects
-- have no standard build output location.
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
