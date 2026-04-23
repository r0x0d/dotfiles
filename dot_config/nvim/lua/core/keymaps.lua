local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Visual line movement (respects word wrap)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (visual line)" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (visual line)" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Toggle diagnostics
map("n", "<leader>td", function()
    vim.g.diagnostics_visible = not vim.g.diagnostics_visible
    vim.diagnostic.enable(vim.g.diagnostics_visible)
    vim.notify("Diagnostics: " .. (vim.g.diagnostics_visible and "ON" or "OFF"))
end, { desc = "Toggle diagnostics" })

-- Toggle autoformat on save
map("n", "<leader>tf", function()
    vim.g.autoformat_enabled = not vim.g.autoformat_enabled
    vim.notify("Autoformat: " .. (vim.g.autoformat_enabled and "ON" or "OFF"))
end, { desc = "Toggle autoformat" })

-- Toggle linting
map("n", "<leader>tl", function()
    vim.g.lint_enabled = not vim.g.lint_enabled
    if vim.g.lint_enabled then
        require("lint").try_lint()
    else
        vim.diagnostic.reset()
    end
    vim.notify("Linting: " .. (vim.g.lint_enabled and "ON" or "OFF"))
end, { desc = "Toggle linting" })

-- Toggle inlay hints
map("n", "<leader>th", function()
    vim.g.inlay_hints_enabled = not vim.g.inlay_hints_enabled
    vim.lsp.inlay_hint.enable(vim.g.inlay_hints_enabled)
    vim.notify("Inlay hints: " .. (vim.g.inlay_hints_enabled and "ON" or "OFF"))
end, { desc = "Toggle inlay hints" })
