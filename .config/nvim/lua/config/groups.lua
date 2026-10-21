-- What loads when. Add a plugin: list it in pack.lua, then give it a group here.
-- Triggers: eager | defer (right after startup) | ft | event | cmd | none
-- (none = loaded from a mapping or another group via loader.load()).
local L = require("config.loader")

local function file_buf(ev) return vim.bo[ev.buf].buftype == "" end
local function setup(mod) return function() require("plugins." .. mod) end end
local on_file = { "BufReadPre", "BufNewFile" }

-- ── always ───────────────────────────────────────────────────────────────
L.group("colorscheme", { eager = true, setup = setup("colorscheme") })
L.group("treesitter", { eager = true, setup = setup("treesitter") })
L.group("oil", { eager = true, setup = setup("oil") })
L.group("mason", { eager = true, setup = setup("mason") }) -- puts mason/bin on PATH

-- ── after startup ────────────────────────────────────────────────────────
L.group("whichkey", { defer = true, plugins = { "which-key.nvim" }, setup = setup("whichkey") })
L.group("mason-tools", {
  defer = true, requires = { "mason" },
  plugins = { "mason-tool-installer.nvim" }, setup = setup("mason_tools"),
})

-- ── when a real file is opened ───────────────────────────────────────────
L.group("gitsigns", { event = on_file, cond = file_buf, plugins = { "gitsigns.nvim" }, setup = setup("gitsigns") })
L.group("sleuth", { event = on_file, cond = file_buf, plugins = { "vim-sleuth" } })
L.group("context", {
  event = on_file, cond = file_buf,
  plugins = { "nvim-treesitter-context" }, setup = setup("context"),
})
L.group("todo", {
  event = on_file, cond = file_buf,
  plugins = { "plenary.nvim", "todo-comments.nvim" }, setup = setup("todo"),
})
L.group("persistence", {
  event = on_file, cond = file_buf,
  plugins = { "persistence.nvim" }, setup = setup("persistence"),
})

-- ── completion: first insert/cmdline, or the first LSP-enabled file ─────────
L.group("completion", {
  event = { "InsertEnter", "CmdlineEnter" },
  plugins = { "blink.lib", "blink.cmp" }, setup = setup("completion"),
})
-- LSP servers start only once a real file is opened. lsp.enable() loads blink
-- first because blink supplies the client capabilities.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lsp-first-buffer", { clear = true }),
  callback = function(ev)
    if not file_buf(ev) then return end
    require("config.lsp").enable()
    return true
  end,
})

-- ── by language / file type ────────────────────────────────────────────────
-- Python and containers need no plugin of their own: their LSP servers start
-- per filetype (config/lsp.lua) and debugpy/pytest hang off the dap and test
-- groups below.
L.group("rust", { ft = { "rust" }, requires = { "dap" }, plugins = { "rustaceanvim" } })
L.group("markdown", { ft = { "markdown" }, plugins = { "render-markdown.nvim" }, setup = setup("markdown") })
L.group("db", {
  ft = { "sql", "mysql", "plsql" },
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer", "DB" },
  plugins = { "vim-dadbod", "vim-dadbod-ui", "vim-dadbod-completion" },
  init = setup("db"),
})

-- ── on first use (command or mapping) ──────────────────────────────────────
L.group("telescope", {
  cmd = { "Telescope" },
  plugins = {
    "plenary.nvim", "telescope.nvim", "telescope-fzf-native.nvim", "telescope-ui-select.nvim",
  },
  setup = setup("telescope"),
})
L.group("todo-telescope", { cmd = { "TodoTelescope" }, requires = { "todo", "telescope" } })
L.group("trouble", { cmd = { "Trouble" }, plugins = { "trouble.nvim" }, setup = setup("trouble") })
L.group("diffview", {
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
  plugins = { "plenary.nvim", "diffview.nvim" },
})
L.group("octo", {
  cmd = { "Octo" }, requires = { "telescope" },
  plugins = { "plenary.nvim", "octo.nvim" }, setup = setup("octo"),
})
L.group("format", { cmd = { "Format", "ConformInfo" }, plugins = { "conform.nvim" }, setup = setup("format") })
L.group("imgclip", { cmd = { "PasteImage" }, plugins = { "img-clip.nvim" }, setup = setup("imgclip") })
L.group("terminal", {
  cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermSelect", "TermExec", "Run" },
  plugins = { "toggleterm.nvim" }, setup = setup("terminal"),
})
L.group("dap", {
  cmd = { "DapContinue", "DapToggleBreakpoint" },
  plugins = {
    "nvim-nio", "nvim-dap", "nvim-dap-ui", "nvim-dap-virtual-text", "nvim-dap-python",
  },
  setup = setup("dap"),
})
L.group("test", {
  cmd = { "Neotest" }, requires = { "rust" },
  plugins = { "plenary.nvim", "nvim-nio", "neotest", "neotest-python" }, setup = setup("test"),
})
L.group("schemastore", { plugins = { "schemastore.nvim" } }) -- from the yaml/json LSP configs
-- Dashboard: shown only when started without files, otherwise via <Space>;
L.group("dashboard", {
  eager = vim.fn.argc() == 0, requires = { "persistence" },
  plugins = { "mini.starter" }, setup = setup("dashboard"),
})
