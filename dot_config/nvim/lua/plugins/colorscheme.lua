return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        flavour = "mocha",
        integrations = {
            gitsigns = true,
            mason = true,
            cmp = true,
            treesitter = true,
            telescope = { enabled = true },
            render_markdown = true,
            dap = true,
            dap_ui = true,
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
    end,
}
