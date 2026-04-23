return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
        { "<leader>e", "<cmd>Oil<CR>", desc = "File explorer" },
    },
    opts = {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["q"] = "actions.close",
            ["<Esc>"] = "actions.close",
        },
    },
}
