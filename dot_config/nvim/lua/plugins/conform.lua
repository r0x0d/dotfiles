return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            python = { "ruff_format" },
            rust = { "rustfmt" },
            lua = { "stylua" },
            markdown = { "prettier" },
            ["_"] = { "trim_whitespace" },
        },
        format_on_save = function()
            if not vim.g.autoformat_enabled then
                return
            end
            return { timeout_ms = 3000, lsp_format = "fallback" }
        end,
    },
}
