vim.loader.enable()

require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Disable bundled plugins (previously handled by lazy.nvim)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1

vim.cmd.colorscheme("ptyxis")

-- Generate helptags for custom docs
vim.cmd("silent! helptags " .. vim.fn.stdpath("config") .. "/doc")
