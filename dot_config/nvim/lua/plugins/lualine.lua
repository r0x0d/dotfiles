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

    -- LSP emoji mappings
    local lsp_emojis = {
      lua_ls = "🌙",
      python_ls = "🐍",
      ruff_ls = "🐍",
      ts_ls = "📘",
      tsserver = "📘",
      rust_analyzer = "🦀",
      gopls = "🐹",
      clangd = "🔧",
      jdtls = "☕",
      html = "🌐",
      cssls = "🎨",
      json_ls = "📋",
      yaml_ls = "📄",
      markdown_ls = "📄",
      bash_ls = "🐚",
      docker_ls = "🐳",
      tailwindcss = "🎨",
      emmet_ls = "⚡",
      eslint = "🔍",
      phpactor = "🐘",
      ruby_ls = "💎",
      csharp_ls = "#️⃣",
      omnisharp = "#️⃣",
    }

    -- Show LSP client(s) attached with emojis
    local function lsp_name()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local names = {}

      for _, client in pairs(clients) do
        local client_name = string.gsub(client.name, "-", "_")
        local emoji = lsp_emojis[client_name] or "🔌"
        table.insert(names, emoji .. " " .. client.name)
      end

      if #names == 0 then
        return "⚠️ No LSP"
      end

      return table.concat(names, " | ")
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
