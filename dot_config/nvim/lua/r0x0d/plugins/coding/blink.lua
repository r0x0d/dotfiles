-- Blink: Auto-completion and related plugins
local icons = require 'r0x0d.util.icons'

return {
    -- Auto-completion
    {
        'saghen/blink.cmp',
        version = '1.*',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'moyiz/blink-emoji.nvim',
            'Kaiser-Yang/blink-cmp-git',
        },
        event = 'InsertEnter',
        opts = {
            keymap = {
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-\\>'] = { 'hide', 'fallback' },
                ['<C-n>'] = { 'select_next', 'show' },
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<C-p>'] = { 'select_prev' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            completion = {
                list = {
                    -- Insert items while navigating the completion list.
                    selection = { preselect = false, auto_insert = true },
                    max_items = 25,
                },
                documentation = { auto_show = true },
                menu = {
                    scrollbar = false,
                    draw = {
                        gap = 2,
                        columns = {
                            { 'kind_icon', 'kind', gap = 1 },
                            { 'label', 'label_description', gap = 1 },
                        },
                    },
                },
            },
            snippets = { preset = 'luasnip' },
            -- Disable command line completion:
            cmdline = { enabled = false },
            sources = {
                -- Disable some sources in comments and strings.
                default = function()
                    local sources = { 'git', 'lsp', 'buffer', 'emoji' }
                    local ok, node = pcall(vim.treesitter.get_node)

                    if ok and node then
                        if not vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                            table.insert(sources, 'path')
                        end
                        if node:type() ~= 'string' then
                            table.insert(sources, 'snippets')
                        end
                    end

                    return sources
                end,
                providers = {
                    emoji = {
                        module = 'blink-emoji',
                        name = 'Emoji',
                        score_offset = 15,
                        opts = {
                            insert = true,
                            ---@type string|table|fun():table
                            trigger = function()
                                return { ':' }
                            end,
                        },
                        should_show_items = function()
                            return vim.tbl_contains(
                                -- Enable emoji completion only for git commits and markdown.
                                { 'gitcommit', 'markdown' },
                                vim.o.filetype
                            )
                        end,
                    },
                    git = {
                        module = 'blink-cmp-git',
                        name = 'Git',
                    },
                },
            },
            appearance = {
                kind_icons = icons.symbol_kinds,
            },
        },
        config = function(_, opts)
            require('blink.cmp').setup(opts)
        end,
    },
    -- Indentation guides
    {
        'saghen/blink.indent',
        opts = {
            static = {
                char = icons.misc.vertical_bar,
            },
            scope = {
                char = icons.misc.vertical_bar,
                highlights = { 'LineNr' },
            },
        },
    },
    -- Auto pairs
    {
        'saghen/blink.pairs',
        version = '*',
        dependencies = 'saghen/blink.download',
        opts = {
            mappings = {
                enabled = true,
                cmdline = true,
                disabled_filetypes = {},
                pairs = {},
            },
            highlights = {
                enabled = true,
                cmdline = true,
                groups = {
                    'BlinkPairsOrange',
                    'BlinkPairsPurple',
                    'BlinkPairsBlue',
                },
                unmatched_group = 'BlinkPairsUnmatched',
                matchparen = {
                    enabled = true,
                    cmdline = false,
                    include_surrounding = false,
                    group = 'BlinkPairsMatchParen',
                    priority = 250,
                },
            },
            debug = false,
        },
    },
}

