return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile' }, -- Only load when needed
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' }, -- Commands that require treesitter to be loaded
    opts = {
      ensure_installed = {
        'bash',
        'diff',
        'lua',
        'c',
        'cpp',
        'luadoc',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'rust',
        'python',
        'ini',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'json',
        'jsonc',
        'toml',
        'yaml',
        'ruby',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'dockerfile' },
      },
      indent = { 
        enable = true,
        -- Prevent treeitter to unindent yaml lists
        disable = {'yaml'}
      },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
