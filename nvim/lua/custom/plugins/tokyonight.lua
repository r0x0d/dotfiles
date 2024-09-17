return {
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
    lazy = false,
    priority = 1000,
  },
}
