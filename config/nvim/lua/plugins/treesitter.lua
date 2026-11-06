-- (install() is a no-op for parsers already present; norg parsers are built
-- separately in neorg.lua since the installer cannot compile them.)
-- Parser install checks run after startup, off the critical path
require("config.util").defer(function()
require("nvim-treesitter").install({
  "lua", "vim", "vimdoc", "python", "rust", "bash", "yaml", "toml",
  "json", "sql", "fish", "c", "regex", "dockerfile", "markdown", "markdown_inline", "diff",
})
end)
