return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = {
            "python", "rust", "c_sharp", "gdscript",
            "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline",
            "toml", "yaml", "json", "bash",
        },
        highlight = { enable = true },
    },
}
