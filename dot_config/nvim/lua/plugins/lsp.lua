return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ui = { border = "rounded" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "basedpyright",
                "rust_analyzer",
                "omnisharp",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- LspAttach keymaps (only active in LSP-attached buffers)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("K", vim.lsp.buf.hover, "Hover documentation")
                    map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
                    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
                    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
                end,
            })

            -- Shared capabilities for all servers (completion support from cmp)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Server-specific overrides
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            inlayHints = {
                                variableTypes = true,
                                functionReturnTypes = true,
                                callArgumentNames = "all",
                                pytestParameters = true,
                            },
                        },
                    },
                },
            })

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = { command = "clippy" },
                        inlayHints = {
                            chainingHints = { enable = true },
                            parameterHints = { enable = true },
                            typeHints = { enable = true },
                        },
                    },
                },
            })

            -- Enable servers (configs are shipped by nvim-lspconfig as runtime files)
            vim.lsp.enable({ "basedpyright", "rust_analyzer", "omnisharp", "gdscript" })

            vim.diagnostic.config({
                virtual_text = { spacing = 4, prefix = "●" },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = "rounded" },
            })
        end,
    },
}
