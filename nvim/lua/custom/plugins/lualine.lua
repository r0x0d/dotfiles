return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      theme = 'tokyonight',
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics', { 'filename', file_status = false }, { modified } },
        lualine_c = {},
      },
    },
    dependencies = { 'nvim-web-devicons' },
  },
}
