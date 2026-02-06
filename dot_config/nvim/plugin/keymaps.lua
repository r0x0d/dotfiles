-- Global keymaps (non-plugin specific)

local map = vim.keymap.set

-- Better window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize windows with arrows
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move lines up and down
map('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })

-- Keep cursor centered when scrolling
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

-- Keep cursor centered when searching
map('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

-- Better paste (don't overwrite register)
map('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting register' })

-- Delete without yanking
map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

-- Quick escape from insert mode
map('i', 'jk', '<Esc>', { desc = 'Escape insert mode' })

-- Clear search highlighting
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlighting' })

-- Better indenting (stay in visual mode)
map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Quickfix navigation
map('n', '[q', '<cmd>cprev<cr>zz', { desc = 'Previous quickfix item' })
map('n', ']q', '<cmd>cnext<cr>zz', { desc = 'Next quickfix item' })

-- Buffer navigation
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })

