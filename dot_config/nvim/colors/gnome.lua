-- GNOME Adwaita dark colorscheme for Neovim
-- Entry point: loaded by `:colorscheme gnome`

vim.o.termguicolors = true

-- Reset existing highlights
if vim.g.colors_name then
    vim.cmd 'highlight clear'
end

if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd 'syntax reset'
end

vim.g.colors_name = 'gnome'
vim.o.background = 'dark'

-- Apply all highlight groups
require('r0x0d.theme.gnome.highlights').setup()
