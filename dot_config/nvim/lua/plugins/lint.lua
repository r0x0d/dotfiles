return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            python = { "ruff" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = function()
                if vim.g.lint_enabled then
                    lint.try_lint()
                end
            end,
        })
    end,
}
