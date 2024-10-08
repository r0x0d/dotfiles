return {
  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  },
  {
    {
      "ldelossa/gh.nvim",
      dependencies = {
        {
          "ldelossa/litee.nvim",
          config = function()
            require("litee.lib").setup()
          end,
        },
      },
      config = function()
        require("litee.gh").setup()
      end,
    }
  },
}
