vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "master" },
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
})

local libfzf = vim.api.nvim_get_runtime_file("build/libfzf.so", false)
if #libfzf == 0 then
    local src = vim.api.nvim_get_runtime_file("src/fzf.c", false)
    if #src > 0 then
        vim.system({ "make" }, { cwd = vim.fs.dirname(vim.fs.dirname(src[1])) }):wait()
    end
end

local telescope = require("telescope")
telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules", ".git/", "__pycache__", "%.pyc" },
        path_display = { "truncate" },
    },
    extensions = {
        fzf = {},
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
    },
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep (rg)" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Fuzzy find in buffer" })
