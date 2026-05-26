vim.pack.add({
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
})

-- Mason setup
require("mason").setup({
    ui = { border = "rounded" },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "rust_analyzer",
        "omnisharp",
        "stylua",
    },
})

