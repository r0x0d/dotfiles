return {
  'nvim-lualine/lualine.nvim',
  config = function()
    ---------------------------------------------------------------------------
    -- 3024 COLORS
    ---------------------------------------------------------------------------
    local colors = {
      black   = "#090300",
      red     = "#db2d20",
      green   = "#01a252",
      yellow  = "#fded02",
      blue    = "#01a0e4",
      magenta = "#a16a94",
      cyan    = "#b5e4f4",
      white   = "#a5a2a2",

      bright_black   = "#5c5855",
      bright_red     = "#e8bbd0",
      bright_green   = "#3a3432",
      bright_yellow  = "#4a4543",
      bright_blue    = "#807d7c",
      bright_magenta = "#d6d5d4",
      bright_cyan    = "#cdab53",
      bright_white   = "#f7f7f7",

      bg = "#090300",
      fg = "#a5a2a2",
    }

    ---------------------------------------------------------------------------
    -- LUALINE THEME
    ---------------------------------------------------------------------------
    local theme_3024 = {
      normal = {
        a = { fg = colors.black, bg = colors.blue, gui = "bold" },
        b = { fg = colors.white, bg = colors.bright_black },
        c = { fg = colors.fg, bg = colors.bg },
      },
      insert = {
        a = { fg = colors.black, bg = colors.green, gui = "bold" },
        b = { fg = colors.white, bg = colors.bright_black },
        c = { fg = colors.fg, bg = colors.bg },
      },
      visual = {
        a = { fg = colors.black, bg = colors.magenta, gui = "bold" },
        b = { fg = colors.white, bg = colors.bright_black },
        c = { fg = colors.fg, bg = colors.bg },
      },
      replace = {
        a = { fg = colors.black, bg = colors.red, gui = "bold" },
        b = { fg = colors.white, bg = colors.bright_black },
        c = { fg = colors.fg, bg = colors.bg },
      },
      command = {
        a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
        b = { fg = colors.white, bg = colors.bright_black },
        c = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        a = { fg = colors.bright_black, bg = colors.bg, gui = "bold" },
        b = { fg = colors.bright_black, bg = colors.bg },
        c = { fg = colors.bright_black, bg = colors.bg },
      },
    }

    ---------------------------------------------------------------------------
    -- HELPER COMPONENTS
    ---------------------------------------------------------------------------

    -- Project name (last folder of CWD)
    local function project_name()
      local cwd = vim.fn.getcwd()
      return cwd:match("([^/]+)$")
    end

    -- Show LSP client(s) attached (Neovim 0.9+)
    local function lsp_name()
      local clients = vim.lsp.get_clients({ bufnr = 0 }) -- attach to current buffer
      local buf_ft = vim.bo.filetype
      local names = {}

      for _, client in pairs(clients) do
        if client.supported_filetypes and vim.tbl_contains(client.supported_filetypes, buf_ft) then
          table.insert(names, client.name)
        elseif client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
          table.insert(names, client.name)
        end
      end

      if #names == 0 then
        return "No LSP"
      end
      return "LSP: " .. table.concat(names, ", ")
    end
    -- Indentation
    local function indent_info()
      local expand = vim.bo.expandtab and "spaces" or "tabs"
      return expand .. ":" .. vim.bo.shiftwidth
    end

    ---------------------------------------------------------------------------
    -- LUALINE SETUP
    ---------------------------------------------------------------------------
    require('lualine').setup({
      options = {
        theme = theme_3024,
        icons_enabled = true,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
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
          { project_name, icon = '󰉋' },
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
          'location'
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
    })
  end
}
