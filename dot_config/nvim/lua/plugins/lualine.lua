return {
  'nvim-lualine/lualine.nvim',
  config = function()
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
        theme = "catppuccin",
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
