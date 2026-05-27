local add_on_event = require('vim-pack').add_on_event

-- Async linting.
add_on_event({ 'BufReadPre', 'BufNewFile' }, {
    {
        src = 'mfussenegger/nvim-lint',
        module_name = 'lint',
        setup = false,
        on_setup = function()
            local lint = require('lint')

            lint.linters_by_ft = {
                python = { 'ruff' },
                sh = { 'shellcheck' },
                bash = { 'shellcheck' },
                yaml = { 'yamllint' },
                markdown = { 'markdownlint' },
            }

            vim.g.lint_enabled = true

            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
                callback = function()
                    if vim.g.lint_enabled then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },
})
