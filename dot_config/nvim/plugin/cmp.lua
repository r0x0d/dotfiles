vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/moyiz/blink-emoji.nvim",
    "https://github.com/Kaiser-Yang/blink-cmp-git",
    "https://github.com/mikavilpas/blink-ripgrep.nvim",
})

require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    completion = {
        menu = { auto_show = false },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = false },
    },

    signature = { enabled = true },

    appearance = { nerd_font_variant = "mono" },

    sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "ripgrep" },
        per_filetype = {
            gitcommit = { inherit_defaults = true, "git" },
        },
        providers = {
            emoji = {
                module = "blink-emoji",
                name = "Emoji",
                score_offset = 5,
            },
            git = {
                module = "blink-cmp-git",
                name = "Git",
                opts = {},
            },
            ripgrep = {
                module = "blink-ripgrep",
                name = "Ripgrep",
                score_offset = -3,
            },
            snippets = {
                opts = {
                    friendly_snippets = true,
                    extended_filetypes = {
                        markdown = { 'jekyll' },
                        sh = { 'shelldoc' },
                        cpp = { 'unreal' }
                    },
                },
                name = "Snippets",
            }
        },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
})
