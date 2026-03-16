-- Telescope: Fuzzy finder and picker
local icons = require 'r0x0d.util.icons'

return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            'nvim-telescope/telescope-ui-select.nvim',
        },
        keys = {
            -- Core pickers
            { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
            { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Grep' },
            { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
            { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help' },
            { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
            { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Grep word under cursor' },
            { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
            { '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document symbols' },
            { '<leader>fr', '<cmd>Telescope resume<cr>', desc = 'Resume last picker' },
            { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Fuzzy search in buffer' },
            { '<leader><leader>', '<cmd>Telescope buffers<cr>', desc = 'Quick buffer switch' },
            { 'z=', '<cmd>Telescope spell_suggest<cr>', desc = 'Spelling suggestions' },
            { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
        },
        opts = function()
            local actions = require('telescope.actions')

            return {
                defaults = {
                    prompt_prefix = icons.ui.prompt,
                    selection_caret = icons.ui.selection,
                    entry_prefix = icons.ui.entry,
                    sorting_strategy = 'ascending',
                    layout_strategy = 'horizontal',
                    layout_config = {
                        horizontal = {
                            prompt_position = 'top',
                            preview_width = 0.4,
                        },
                        width = 0.8,
                        height = 0.8,
                    },
                    mappings = {
                        i = {
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                            ['<Esc>'] = actions.close,
                        },
                        n = {
                            ['q'] = actions.close,
                        },
                    },
                    file_ignore_patterns = { '.venv', 'venv', 'node_modules', '.git/' },
                    path_display = { 'truncate' },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = { '--hidden' },
                    },
                    buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
                        mappings = {
                            i = {
                                ['<C-d>'] = actions.delete_buffer,
                            },
                        },
                    },
                    help_tags = {
                        mappings = {
                            i = {
                                ['<CR>'] = actions.select_vertical,
                            },
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown {},
                    },
                },
            }
        end,
        config = function(_, opts)
            local telescope = require('telescope')
            telescope.setup(opts)

            -- Load extensions
            telescope.load_extension 'fzf'
            telescope.load_extension 'ui-select'
        end,
        init = function()
            -- Override vim.ui.select with telescope
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(items, opts, on_choice)
                -- Lazy load telescope when vim.ui.select is first called
                require('telescope').load_extension 'ui-select'
                return vim.ui.select(items, opts, on_choice)
            end
        end,
    },
}

