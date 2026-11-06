require("mason-tool-installer").setup({
  ensure_installed = {
    -- LSP (rpm_spec_ls is not in mason: `dnf install rpm-spec-language-server`)
    "basedpyright",
    "ruff",
    "rust-analyzer",
    "dockerfile-language-server",
    "yaml-language-server",
    "json-lsp",
    "taplo",
    "bash-language-server",
    "lua-language-server",
    -- Formatters (rustfmt: `dnf install rustfmt`; falls back to the LSP)
    "shfmt",
    "stylua",
    "prettier",
    -- DAP
    "codelldb",
    "debugpy",
  },
  -- auto_update off: updates are explicit (:MasonToolsUpdate) so a startup
  -- never swaps a toolchain under you.
  auto_update = false,
  run_on_start = true,
  -- delay keeps installs off the startup critical path
  start_delay = 1000,
})

-- Servers installed after startup were skipped by the first enable()
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsUpdateCompleted",
  callback = function() vim.schedule(function() require("config.lsp").enable() end) end,
})
