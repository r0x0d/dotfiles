return {
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        require('telescope').load_extension 'projects',
      }
      vim.keymap.set('n', '<leader>lp', '<cmd> Telescope project<CR>', { desc = '[L]oad [P]project' })
    end,
  },
}
