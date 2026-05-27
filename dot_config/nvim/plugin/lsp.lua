local add = require('vim-pack').add

-- LSP configuration with blink.cmp completion integration.
add {
    {
        src = 'neovim/nvim-lspconfig',
        module_name = 'lspconfig',
        setup = false,
        on_setup = function()
            -- Advertise blink.cmp completion capabilities to all LSP servers.
            vim.lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(),
            })

            -- Enable servers (per-server config lives in after/lsp/*.lua,
            -- nvim-lspconfig provides defaults for servers without one).
            vim.lsp.enable({
                'basedpyright',
                'jsonls',
                'lua_ls',
                'ruff',
                'yamlls',
                'rust_analyzer',
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local bufnr = args.buf
                    local function map(lhs, rhs, desc)
                        vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
                    end

                    map('gd', vim.lsp.buf.definition, 'Go to definition')
                    map('gD', vim.lsp.buf.declaration, 'Go to declaration')
                    map('gy', vim.lsp.buf.type_definition, 'Type definition')
                end,
            })
        end,
    },
}
