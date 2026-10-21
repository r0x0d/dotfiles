local map = vim.keymap.set
local loader = require("config.loader")

-- Wrap a mapping so the plugin group it needs is loaded first
local function use(group, fn)
  return function()
    loader.load(group)
    fn()
  end
end

map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Leave terminal mode" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "-", "<cmd>Oil<cr>", { desc = "File explorer" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

-- Git
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
map("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" })

-- Diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- DAP
local function dap(fn, ...)
  local args = { ... }
  return use("dap", function()
    local f = require("dap")
    for part in fn:gmatch("[^.]+") do f = f[part] end
    f(unpack(args))
  end)
end
map("n", "<F5>", dap("continue"), { desc = "DAP continue" })
map("n", "<F10>", dap("step_over"), { desc = "DAP step over" })
map("n", "<F11>", dap("step_into"), { desc = "DAP step into" })
map("n", "<F12>", dap("step_out"), { desc = "DAP step out" })
map("n", "<leader>db", dap("toggle_breakpoint"), { desc = "Breakpoint" })
map("n", "<leader>dB", use("dap", function()
  require("dap").set_breakpoint(vim.fn.input("Condition: "))
end), { desc = "Conditional breakpoint" })
map("n", "<leader>du", use("dap", function() require("dapui").toggle() end), { desc = "Debug UI" })
map({ "n", "v" }, "<leader>de", use("dap", function() require("dapui").eval() end), { desc = "Eval" })
map("n", "<leader>dr", dap("repl.toggle"), { desc = "REPL" })
map("n", "<leader>dl", dap("run_last"), { desc = "Run last" })

-- Neotest
local function nt(fn) return use("test", function() fn(require("neotest")) end) end
map("n", "<leader>tt", nt(function(n) n.run.run() end), { desc = "Test nearest" })
map("n", "<leader>tf", nt(function(n) n.run.run(vim.fn.expand("%")) end), { desc = "Test file" })
map("n", "<leader>td", nt(function(n) n.run.run({ strategy = "dap" }) end), { desc = "Debug nearest test" })
map("n", "<leader>tl", nt(function(n) n.run.run_last() end), { desc = "Test last" })
map("n", "<leader>ts", nt(function(n) n.summary.toggle() end), { desc = "Test summary" })
map("n", "<leader>to", nt(function(n) n.output.open({ enter = true }) end), { desc = "Test output" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
map("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "LSP references" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix" })
map("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "TODOs" })

-- Misc
map("n", "<leader>D", "<cmd>DBUIToggle<cr>", { desc = "Database UI" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "TODOs" })
map("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "Paste image from clipboard" })

-- Cheatsheet for this config (doc/myconfig.txt)
map("n", "<leader>?", "<cmd>help myconfig<cr>", { desc = "Config cheatsheet" })

-- Format (manual only, via conform; no format-on-save)
map({ "n", "v" }, "<leader>lf", use("format", function()
  require("conform").format({ async = true })
end), { desc = "Format" })

-- Sessions and dashboard
map("n", "<leader>sr", use("persistence", function() require("persistence").load() end), { desc = "Restore session (this dir)" })
map("n", "<leader>sl", use("persistence", function() require("persistence").load({ last = true }) end), { desc = "Restore last session" })
map("n", "<leader>ss", use("persistence", function() require("persistence").select() end), { desc = "Pick a session" })
map("n", "<leader>sd", use("persistence", function() require("persistence").stop() end), { desc = "Don't save session on exit" })
map("n", "<leader>;", use("dashboard", function() require("mini.starter").open() end), { desc = "Dashboard" })

-- TODO comments
map("n", "]t", use("todo", function() require("todo-comments").jump_next() end), { desc = "Next TODO" })
map("n", "[t", use("todo", function() require("todo-comments").jump_prev() end), { desc = "Prev TODO" })

-- Terminal: the :ToggleTerm family loads toggleterm on first use. <C-\> and
-- <leader>og need a loader step first; toggleterm then installs its own <C-\>.
map("n", "<leader>ot", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
map("n", "<leader>oh", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
map("n", "<leader>ov", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical terminal" })
map("n", "<leader>og", use("terminal", function() require("plugins.terminal").lazygit() end), { desc = "Lazygit" })
map("n", "<C-\\>", use("terminal", function() vim.cmd(vim.v.count .. "ToggleTerm") end), { desc = "Toggle terminal" })
