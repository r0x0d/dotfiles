require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_organize_imports", "ruff_format" },
    rust = { "rustfmt" },
    lua = { "stylua" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    fish = { "fish_indent" },
    toml = { "taplo" },
    yaml = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
  },
  -- Formatting is manual only (<leader>lf / :Format): no format_on_save.
  -- Filetypes without a formatter fall back to the LSP.
  default_format_opts = { lsp_format = "fallback" },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range
  if args.count ~= -1 then
    local last = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = { start = { args.line1, 0 }, ["end"] = { args.line2, #last } }
  end
  require("conform").format({ async = true, range = range })
end, { range = true, desc = "Format buffer or range" })
