-- Plugin specifications for r0x0d's Neovim config
-- This file defines all plugins used in the configuration

return {
  -- UI
  { import = 'r0x0d.plugins.ui' },
  { import = 'r0x0d.plugins.completion' },
  { import = 'r0x0d.plugins.lsp' },
  { import = 'r0x0d.plugins.utility' },
  { import = 'r0x0d.plugins.git' },
}