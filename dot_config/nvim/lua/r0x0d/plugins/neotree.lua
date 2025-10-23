return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = true,
    cmd = { 'Neotree' },
    keys = {
      { '\\\\', '<CMD>Neotree toggle<CR>', desc = 'Toggle NeoTree' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons', -- optional, but recommended
    },
  },
}
