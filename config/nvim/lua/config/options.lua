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
o.updatetime = 250
o.timeoutlen = 400
o.completeopt = { "menu", "menuone", "noselect", "popup", "fuzzy" }
o.laststatus = 3
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

-- `:` command-line completion menu as you type
o.wildmode = "noselect:lastused,full"
o.wildoptions = "pum,fuzzy"
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = ":",
  callback = function() vim.fn.wildtrigger() end,
  desc = "as-you-type command-line completion",
})

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
vim.filetype.add({
  pattern = {
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    ["compose.*%.ya?ml"] = "yaml.docker-compose",
  },
})
