-- Lualine: Status line
local icons = require 'r0x0d.util.icons'

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        ---------------------------------------------------------------------------
        -- HELPER: CACHING
        ---------------------------------------------------------------------------

        -- Cache expensive computations with a TTL to avoid recalculating every
        -- statusline redraw.  Each entry stores { value, timestamp }.
        local cache = {}

        --- Return a cached value or recompute it if stale.
        ---@param key string
        ---@param ttl_ms number  milliseconds before the value is considered stale
        ---@param fn fun(): any
        ---@return any
        local function cached(key, ttl_ms, fn)
            local entry = cache[key]
            local now = vim.uv.hrtime() / 1e6 -- ms
            if entry and (now - entry[2]) < ttl_ms then
                return entry[1]
            end
            local value = fn()
            cache[key] = { value, now }
            return value
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Project name
        ---------------------------------------------------------------------------

        --- Short project/workspace name derived from cwd.
        local function project_name()
            return cached('project', 5000, function()
                local cwd = vim.fn.getcwd()
                return icons.misc.project .. ' ' .. vim.fn.fnamemodify(cwd, ':t')
            end)
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Python virtualenv
        ---------------------------------------------------------------------------

        --- Show the active Python virtual-env name (if any).
        local function python_venv()
            if vim.bo.filetype ~= 'python' then
                return ''
            end
            return cached('venv', 3000, function()
                local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV
                if not venv then
                    return ''
                end
                return icons.misc.venv .. ' ' .. vim.fn.fnamemodify(venv, ':t')
            end)
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Macro recording
        ---------------------------------------------------------------------------

        --- Show macro recording status (e.g. "Recording @q").
        local function macro_recording()
            local reg = vim.fn.reg_recording()
            if reg ~= '' then
                return 'Recording @' .. reg
            end
            return ''
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Search count
        ---------------------------------------------------------------------------

        --- Show search count (e.g. "3/15") during an active search.
        local function search_count()
            if vim.v.hlsearch == 0 then
                return ''
            end
            local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })
            if not ok or next(result) == nil then
                return ''
            end
            if result.incomplete == 1 then
                return icons.misc.search .. ' ?/?'
            end
            local current = result.current
            local total = result.total
            if total == 0 then
                return ''
            end
            return icons.misc.search .. ' ' .. current .. '/' .. total
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Autoformat toggle
        ---------------------------------------------------------------------------

        --- Show autoformat toggle status (visible indicator for :ToggleFormat).
        local function autoformat_status()
            if vim.g.autoformat then
                return icons.misc.formatting
            end
            return icons.misc.no_formatting
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: DAP / Debug session
        ---------------------------------------------------------------------------

        --- Show debug session status when DAP is active.
        local function dap_status()
            local dap_ok, dap = pcall(require, 'dap')
            if not dap_ok then
                return ''
            end
            local session = dap.session()
            if not session then
                return ''
            end
            return icons.misc.bug .. ' ' .. (session.config.name or 'Debug')
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Filetype with icon and LSP indicator
        ---------------------------------------------------------------------------

        --- Filetype with devicon and LSP status badge:
        ---   e.g.  " lua ●"  or  " rust"
        local function filetype_plus()
            local ft = vim.bo.filetype
            if ft == '' then
                return 'no ft'
            end

            -- Try to grab the devicon for this filetype.
            local icon = ''
            local ok, devicons = pcall(require, 'nvim-web-devicons')
            if ok then
                icon = devicons.get_icon_by_filetype(ft) or ''
            end

            -- LSP attached?
            local lsp_badge = ''
            if #vim.lsp.get_clients { bufnr = 0 } > 0 then
                lsp_badge = ' ●'
            end

            if icon ~= '' then
                return icon .. ' ' .. ft .. lsp_badge
            end
            return ft .. lsp_badge
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Indentation style
        ---------------------------------------------------------------------------

        --- Indentation style and width.
        local function indent_info()
            local expand = vim.bo.expandtab and 'spaces' or 'tabs'
            return expand .. ':' .. vim.bo.shiftwidth
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Encoding (conditional)
        ---------------------------------------------------------------------------

        --- Only show encoding when it is not the default (utf-8).
        local function encoding_conditional()
            local enc = vim.bo.fileencoding
            if enc ~= '' and enc ~= 'utf-8' then
                return enc
            end
            return ''
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: File size
        ---------------------------------------------------------------------------

        --- Human-readable file size for the current buffer.
        local function file_size()
            local file = vim.fn.expand '%:p'
            if file == '' or file == nil then
                return ''
            end
            local size = vim.fn.getfsize(file)
            if size <= 0 then
                return ''
            end
            local suffixes = { 'B', 'KB', 'MB', 'GB' }
            local i = 1
            while size > 1024 and i < #suffixes do
                size = size / 1024
                i = i + 1
            end
            local fmt = i == 1 and '%d %s' or '%.1f %s'
            return icons.misc.file_size .. ' ' .. string.format(fmt, size, suffixes[i])
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Line count
        ---------------------------------------------------------------------------

        --- Total line count for the current buffer.
        local function line_count()
            local lines = vim.api.nvim_buf_line_count(0)
            return icons.misc.lines .. ' ' .. lines .. 'L'
        end

        ---------------------------------------------------------------------------
        -- COMPONENT: Lazy plugin updates
        ---------------------------------------------------------------------------

        --- Show number of pending Lazy plugin updates (cached, checked rarely).
        local function lazy_updates()
            return cached('lazy_updates', 30000, function()
                local lazy_ok, lazy_status = pcall(require, 'lazy.status')
                if lazy_ok and lazy_status.has_updates() then
                    return icons.misc.lazy .. ' ' .. lazy_status.updates()
                end
                return ''
            end)
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
                -------------------------------------------------------------------
                -- LEFT  – "Where am I?"
                -------------------------------------------------------------------
                lualine_a = {
                    'mode',
                },
                lualine_b = {
                    { project_name },
                    'branch',
                    'diff',
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1, -- relative path
                        symbols = { modified = ' ●', readonly = ' ', unnamed = '[No Name]' },
                    },
                    {
                        python_venv,
                        color = { fg = '#a6e3a1' },
                        cond = function()
                            return vim.bo.filetype == 'python'
                        end,
                    },
                },
                -------------------------------------------------------------------
                -- RIGHT – "What's happening?"
                -------------------------------------------------------------------
                lualine_x = {
                    { macro_recording, color = 'DiagnosticError' },
                    { search_count },
                    {
                        dap_status,
                        color = { fg = '#f38ba8' },
                        cond = function()
                            local ok, dap = pcall(require, 'dap')
                            return ok and dap.session() ~= nil
                        end,
                    },
                    { 'diagnostics', sources = { 'nvim_diagnostic' } },
                    { autoformat_status },
                    { lazy_updates },
                },
                lualine_y = {
                    { filetype_plus },
                    { indent_info },
                    { encoding_conditional },
                    { file_size },
                },
                lualine_z = {
                    { line_count },
                    'progress',
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
