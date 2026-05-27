local add = require('vim-pack').add

-- LSP server management via Mason.
add {
    {
        src = 'mason-org/mason.nvim',
        opts = {
            ui = { border = 'rounded' },
        },
    },
    {
        src = 'mason-org/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                'basedpyright',
                'jsonls',
                'lua_ls',
                'ruff',
                'yamlls',
                'rust_analyzer',
            },
        },
    },
    {
        src = 'zapling/mason-lock.nvim',
        opts = {
            lockfile_path = vim.fn.stdpath('config') .. '/mason-lock.json',
        },
    },
}
