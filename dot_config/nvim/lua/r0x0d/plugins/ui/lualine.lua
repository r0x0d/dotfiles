-- Lualine: Status line
local icons = require 'r0x0d.util.icons'

return {
    'nvim-lualine/lualine.nvim',
    config = function()
        ---------------------------------------------------------------------------
        -- HELPER COMPONENTS
        ---------------------------------------------------------------------------
        -- Project name (last folder of CWD)
        local function project_name()
            local cwd = vim.fn.getcwd()
            return cwd:match '([^/]+)$'
        end

        -- Show LSP client(s) attached with emojis
        local function lsp_name()
            local clients = vim.lsp.get_clients { bufnr = 0 }
            local names = {}

            for _, client in pairs(clients) do
                local client_name = string.gsub(client.name, '-', '_')
                local lang_key = icons.lsp_to_language[client_name]
                local emoji = icons.languages[lang_key] or icons.languages.default
                table.insert(names, emoji .. ' ' .. client.name)
            end

            if #names == 0 then
                return icons.languages.none .. ' No LSP'
            end

            return table.concat(names, ' | ')
        end

        -- Indentation
        local function indent_info()
            local expand = vim.bo.expandtab and 'spaces' or 'tabs'
            return expand .. ':' .. vim.bo.shiftwidth
        end
        ---------------------------------------------------------------------------
        -- LUALINE SETUP
        ---------------------------------------------------------------------------
        require('lualine').setup {
            options = {
                theme = 'catppuccin',
                icons_enabled = true,
                component_separators = { left = icons.misc.vertical_bar, right = icons.misc.vertical_bar },
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },
            sections = {
                -----------------------------------------------------------------------
                -- LEFT
                -----------------------------------------------------------------------
                lualine_a = {
                    'mode',
                },
                lualine_b = {
                    'branch',
                    'diff',
                    { project_name, icon = icons.symbol_kinds.Folder },
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1, -- relative path
                    },
                },
                -----------------------------------------------------------------------
                -- RIGHT
                -----------------------------------------------------------------------
                lualine_x = {
                    { 'diagnostics', sources = { 'nvim_diagnostic' } },
                    { lsp_name },
                    { indent_info },
                    'encoding',
                    'fileformat',
                    'filetype',
                },
                lualine_y = {
                    'progress',
                },
                lualine_z = {
                    'location',
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}

