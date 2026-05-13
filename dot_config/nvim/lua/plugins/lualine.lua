return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        -- Konsole colorscheme palette
        -- stylua: ignore
        local colors = {
            blue     = '#5b9bf5',
            green    = '#87d65a',
            yellow   = '#efc050',
            orange   = '#e8875c',
            red      = '#ed5a5a',
            magenta  = '#c77dbb',
            teal     = '#4db8a4',
            text     = '#d3d7cf',
            base     = '#1b1e1f',
            surface1 = '#3e4548',
        }

        local bubbles_theme = {
            normal = {
                a = { fg = colors.base, bg = colors.magenta },
                b = { fg = colors.text, bg = colors.surface1 },
                c = { fg = colors.text },
            },
            insert = { a = { fg = colors.base, bg = colors.blue } },
            visual = { a = { fg = colors.base, bg = colors.teal } },
            replace = { a = { fg = colors.base, bg = colors.red } },
            command = { a = { fg = colors.base, bg = colors.orange } },
            inactive = {
                a = { fg = colors.text, bg = colors.base },
                b = { fg = colors.text, bg = colors.base },
                c = { fg = colors.text },
            },
        }

        require("lualine").setup({
            options = {
                theme = bubbles_theme,
                component_separators = "",
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    { "mode", separator = { left = "" }, right_padding = 2 },
                },
                lualine_b = {
                    { "branch" },
                    {
                        "diff",
                        symbols = { added = "✨ ", modified = "📝 ", removed = "🗑️ " },
                    },
                },
                lualine_c = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1, symbols = { modified = " 💾", readonly = " 🔒", unnamed = "🆕 [No Name]" } },
                },
                lualine_x = {
                    {
                        function()
                            local parts = {}
                            if vim.g.autoformat_enabled then
                                table.insert(parts, "🪄 fmt")
                            end
                            if vim.g.lint_enabled then
                                table.insert(parts, "🔍 lint")
                            end
                            if vim.g.inlay_hints_enabled then
                                table.insert(parts, "💡 hints")
                            end
                            if vim.g.diagnostics_visible then
                                table.insert(parts, "🔬 diag")
                            end
                            return table.concat(parts, "  ")
                        end,
                    },
                    {
                        "diagnostics",
                        symbols = { error = "❌ ", warn = "⚠️ ", info = "ℹ️ ", hint = "💬 " },
                        cond = function() return vim.g.diagnostics_visible end,
                    },
                },
                lualine_y = {
                    {
                        function()
                            local clients = vim.lsp.get_clients({ bufnr = 0 })
                            if #clients == 0 then return "" end
                            local names = {}
                            for _, c in ipairs(clients) do
                                table.insert(names, c.name)
                            end
                            return "⚙️ " .. table.concat(names, ", ")
                        end,
                    },
                },
                lualine_z = {
                    { "location", separator = { right = "" }, left_padding = 2 },
                    { "progress" },
                },
            },
            inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },
        })
    end,
}
