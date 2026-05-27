-- Experimental Lua module loader.
vim.loader.enable()

require("options")
require("keymaps")

-- Disable bundled plugins 
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1

vim.cmd.colorscheme("konsole")

-- Experimental: ui2 message/cmdline redesign (:h ui2)
-- Avoids "Press ENTER" prompts, highlights cmdline, pager as buffer.
require("vim._core.ui2").enable()
