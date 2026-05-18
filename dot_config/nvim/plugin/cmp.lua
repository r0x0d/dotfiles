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
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    completion = {
        menu = { auto_show = false },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
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
        },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
})
