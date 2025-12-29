-- Conform: Autoformat
return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    opts = {
        notify_on_error = true,
        format_on_save = function(bufnr)
            return {
                timeout_ms = 500,
                lsp_format = 'prefer',
            }
        end,
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'ruff_format' },
            go = { 'gofmt' },
            sh = { 'shfmt' },
            -- For filetypes without a formatter:
            ['_'] = { 'trim_whitespace', 'trim_newlines' },
        },
    },
}

