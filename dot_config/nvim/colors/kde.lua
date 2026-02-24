-- KDE Breeze Dark colorscheme for Neovim
-- Entry point: loaded by `:colorscheme kde`

vim.o.termguicolors = true

if vim.g.colors_name then
    vim.cmd 'highlight clear'
end

if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd 'syntax reset'
end

vim.g.colors_name = 'kde'
vim.o.background = 'dark'

require('r0x0d.theme.kde.highlights').setup()
