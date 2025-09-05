-- Autoformat
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
      lua = { name = 'stylua', timeout_ms = 500, lsp_format = 'prefer' },
      python = { name = 'ruff', timeout_ms = 500, lstp_format = 'prefer' },
      go = { name = 'gopls', timeout_ms = 500, lsp_format = 'prefer' },
      sh = { 'shfmt' },
      -- For filetypes without a formatter:
      ['_'] = { 'trim_whitespace', 'trim_newlines' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
