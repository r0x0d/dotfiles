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
-- oil loads on :Oil (the "-" key) or when a directory is opened (`nvim .`)
L.group("oil", { cmd = { "Oil" }, setup = setup("oil") })
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("oil-directory", { clear = true }),
  callback = function(ev)
    if ev.file == "" or vim.fn.isdirectory(ev.file) == 0 then return end
    L.load("oil")
    -- oil's own directory handler was registered after this event fired
    vim.api.nvim_exec_autocmds("BufEnter", { buffer = ev.buf, modeline = false })
    return true
  end,
})
-- mason: the bin dir goes on PATH right away (so installed servers are found);
-- the plugin itself loads for :Mason or the tool installer.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
L.group("mason", {
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
  setup = setup("mason"),
})

-- ── after startup ────────────────────────────────────────────────────────
L.group("whichkey", { defer = true, plugins = { "which-key.nvim" }, setup = setup("whichkey") })
L.group("mason-tools", {
  defer = true, requires = { "mason" },
  plugins = { "mason-tool-installer.nvim" }, setup = setup("mason_tools"),
})
-- Tasks: right after startup rather than on first use, so the statusline
-- segment (config/statusline.lua) is always live. Needs the `task` binary.
L.group("taskwarrior", {
  defer = true,
  plugins = { "taskwarrior.nvim" },
  setup = function() require("plugins.taskwarrior").setup() end,
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

-- LSP servers start only once a real file is opened.
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

-- Notes: the first :Neorg command or .norg file loads the group. The deps
-- are neorg's luarocks rockspec dependencies, installed as git plugins.
L.group("neorg", {
  ft = { "norg" },
  cmd = { "Neorg" },
  plugins = { "neorg", "pathlib.nvim", "lua-utils.nvim", "nui.nvim", "nvim-nio" },
  setup = function() require("plugins.neorg").setup() end,
})
-- ── on first use (command or mapping) ──────────────────────────────────────
L.group("filetree", {
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
  plugins = { "nvim-tree.lua" },
  setup = function() require("plugins.filetree").setup() end,
})
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
