return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics', { 'filename', file_status = false }, { modified } },
        lualine_c = {},
      },
    },
    dependencies = { 'nvim-web-devicons' },
  },
}

