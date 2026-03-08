-- Treesitter: Syntax highlighting and code parsing
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
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
            'dockerfile',
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
            'zig',
        },
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
            -- Prevent treesitter to unindent yaml lists
            disable = { 'yaml' },
        },
    },
    config = function(_, opts)
        -- Prefer git instead of curl in order to improve connectivity in some environments
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)
    end,
}

