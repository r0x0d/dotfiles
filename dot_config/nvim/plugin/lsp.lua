vim.pack.add({
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
})

-- Mason setup
require("mason").setup({
    ui = { border = "rounded" },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "rust_analyzer",
        "omnisharp",
    },
})

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

-- Shared capabilities for all servers (completion support from blink.cmp)
local capabilities = require("blink.cmp").get_lsp_capabilities()
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

vim.lsp.enable({ "basedpyright", "rust_analyzer", "omnisharp", "gdscript" })

vim.diagnostic.config({
    virtual_text = { spacing = 4, prefix = "●" },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded" },
})
