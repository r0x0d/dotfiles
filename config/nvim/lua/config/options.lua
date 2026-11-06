local o = vim.opt

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true
o.colorcolumn = { "80", "120" }
o.termguicolors = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
o.updatetime = 250 -- faster CursorHold (diagnostics, gitsigns) and swap writes
o.timeoutlen = 400 -- short enough to feel snappy, long enough for which-key leader chords
-- "fuzzy" + "noselect": typo-tolerant matches, but never pre-select (Enter stays a newline)
o.completeopt = { "menu", "menuone", "noselect", "popup", "fuzzy" }
o.laststatus = 3 -- one global statusline (see config/statusline.lua)
o.showmode = false -- the statusline shows the mode
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Built-in completion. Sources: current buffer (.), other windows (w),
-- listed buffers (b) and omnifunc (o), which is the LSP when a server is
-- attached (config/lsp.lua) and a plugin function for sql/task buffers.
-- <C-n>/<C-p> select, <C-y> accept, <C-e> close, <C-x><C-f> file paths.
o.autocomplete = true
o.complete = ".,w,b,o"
o.pumheight = 12

-- `:` command line. No "pum" and no CmdlineChanged/wildtrigger, so nothing
-- pops up over the buffer while you type `:q`; <Tab> still completes and
-- lists the matches on the status line.
o.wildmode = "noselect:lastused,full"
o.wildoptions = "fuzzy"

-- Sign text comes from config/icons.lua so the statusline shows the same glyphs
local icons = require("config.icons").diagnostics
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { prefix = "●" },
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.error,
      [vim.diagnostic.severity.WARN] = icons.warn,
      [vim.diagnostic.severity.INFO] = icons.info,
      [vim.diagnostic.severity.HINT] = icons.hint,
    },
  },
})

-- yamlls is attached to compose files via the yaml.docker-compose filetype
-- (dotted filetype: still "yaml" for ftplugins/treesitter, plus a distinct
-- name the compose LSP config can match on)
vim.filetype.add({
  pattern = {
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    ["compose.*%.ya?ml"] = "yaml.docker-compose",
  },
})
