-- Opaque background: transparency would show the terminal's own colors
-- through floats and the statusline. Loaded eagerly so no flash of the default scheme.
require("tokyonight").setup({ style = "night", transparent = false })
vim.cmd.colorscheme("tokyonight")
