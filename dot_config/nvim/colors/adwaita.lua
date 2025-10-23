-- Adwaita colorscheme for Neovim
-- A faithful implementation of GNOME's Adwaita theme
-- Supports both light and dark variants with automatic detection
-- Author: Qwen Code
-- License: MIT

local M = {}

-- Setup function for the colorscheme
function M.setup()
  -- Clear existing highlights
  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'adwaita'

-- Determine if we're using dark or light theme based on various indicators
local function detect_theme()
  -- First check if user explicitly set background
  if vim.o.background then
    return vim.o.background == 'dark'
  end

  -- Check GNOME theme settings
  local handle = io.popen('gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null')
  if handle then
    local result = handle:read('*a'):gsub('%s+', '')
    handle:close()
    if result ~= '' and result ~= 'nil' then
      if result:find('dark') then
        return true
      elseif result:find('light') or result:find('default') then
        return false
      end
    end
  end

  -- Fallback to gtk-theme setting
  handle = io.popen('gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null')
  if handle then
    local result = handle:read('*a'):lower()
    handle:close()
    if result ~= '' and result ~= 'nil' then
      if result:find('dark') then
        return true
      end
    end
  end

  -- Check terminal environment for background color
  if vim.env.TERM_PROGRAM == 'gnome-terminal' or vim.env.GNOME_TERMINAL_SERVICE then
    -- If possible, try to determine from terminal profile
    local success, profile_uuid = pcall(function()
      local f = io.popen('gsettings get org.gnome.Terminal.ProfilesList default 2>/dev/null')
      if f then
        local uuid = f:read('*a'):gsub("%s+", ""):gsub("'", "")
        f:close()
        return uuid
      end
    end)
    
    if success and profile_uuid and profile_uuid ~= '' and profile_uuid ~= 'nil' then
      local cmd = string.format('gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:%s/ background-color 2>/dev/null', profile_uuid:match('[^{]*(.*)') or profile_uuid)
      handle = io.popen(cmd)
      if handle then
        local bg_color = handle:read('*a'):gsub("%s+", ""):gsub("'", "")
        handle:close()
        if bg_color ~= '' and bg_color ~= 'nil' then
          -- Extract RGB values from the color string (e.g. "rgb(43,43,43)")
          local r, g, b = bg_color:match('rgb%((%d+),(%d+),(%d+)%)')
          if r and g and b then
            local brightness = (tonumber(r) * 0.299 + tonumber(g) * 0.587 + tonumber(b) * 0.114) / 255
            return brightness < 0.5
          else
            -- Check for hex format
            local hex_r, hex_g, hex_b = bg_color:match('#(%x%x)(%x%x)(%x%x)')
            if hex_r and hex_g and hex_b then
              local brightness = (tonumber(hex_r, 16) * 0.299 + tonumber(hex_g, 16) * 0.587 + tonumber(hex_b, 16) * 0.114) / 255
              return brightness < 0.5
            end
          end
        end
      end
    end
  end
  
  -- Check terminal background color
  if vim.env.TERM and vim.env.TERM:match('256') then
    -- For terminal-based detection, default to dark theme as it's more common
    return true
  end

  -- Default to dark theme if no other info available
  return true
end

local is_dark = detect_theme()

-- Adwaita color palette
local adwaita_colors = {
  dark = {
    -- Base colors
    window_bg = '#242424',
    window_fg = '#ffffff',
    view_bg = '#1e1e1e',
    view_fg = '#ffffff',
    
    -- Accent colors
    accent_bg = '#3584e4',
    accent_fg = '#ffffff',
    accent = '#78aeed',
    
    -- Destructive colors
    destructive_bg = '#c01c28',
    destructive_fg = '#ffffff',
    destructive = '#ff7b63',
    
    -- Success colors
    success_bg = '#26a269',
    success_fg = '#ffffff',
    success = '#8ff0a4',
    
    -- Warning colors
    warning_bg = '#cd9309',
    warning_fg = 'rgba(0, 0, 0, 0.8)', -- This will be adjusted to #ffffff for terminal
    warning = '#f8e45c',
    
    -- Error colors
    error_bg = '#c01c28',
    error_fg = '#ffffff',
    error = '#ff7b63',
    
    -- Header bar colors
    headerbar_bg = '#303030',
    headerbar_fg = '#ffffff',
    headerbar_backdrop = '#242424',
    
    -- Additional UI colors for Neovim
    border = '#3d3d3d',
    selection = '#3584e4',
    search = '#cd9309',
    match_paren = '#78aeed',
    comment = '#a5a5a5',
    cursor_line = '#303030',
    cursor_column = '#303030',
    visual = '#3584e4',
    line_nr = '#6e6e6e',
    cursor_line_nr = '#78aeed',
    sign_column = '#242424',
    fold_column = '#6e6e6e',
    pmenu = '#242424',
    pmenu_sel = '#3584e4',
    pmenu_sbar = '#3d3d3d',
    pmenu_thumb = '#5b5b5b',
    status_line = '#303030',
    status_line_nc = '#2a2a2a',
    tab_line = '#2a2a2a',
    tab_line_sel = '#303030',
    tab_line_fill = '#242424',
  },
  light = {
    -- Base colors
    window_bg = '#fafafa',
    window_fg = 'rgba(0, 0, 0, 0.8)', -- Adjusted for terminal compatibility
    view_bg = '#ffffff',
    view_fg = 'rgba(0, 0, 0, 0.8)', -- Adjusted for terminal compatibility
    
    -- Accent colors
    accent_bg = '#3584e4',
    accent_fg = '#ffffff',
    accent = '#1c71d8',
    
    -- Destructive colors
    destructive_bg = '#e01b24',
    destructive_fg = '#ffffff',
    destructive = '#c01c28',
    
    -- Success colors
    success_bg = '#2ec27e',
    success_fg = '#ffffff',
    success = '#1b8553',
    
    -- Warning colors
    warning_bg = '#e5a50a',
    warning_fg = 'rgba(0, 0, 0, 0.8)', -- Adjusted for terminal compatibility
    warning = '#9c6e03',
    
    -- Error colors
    error_bg = '#e01b24',
    error_fg = '#ffffff',
    error = '#c01c28',
    
    -- Header bar colors
    headerbar_bg = '#ffffff',
    headerbar_fg = 'rgba(0, 0, 0, 0.8)', -- Adjusted for terminal compatibility
    headerbar_backdrop = '#fafafa',
    
    -- Additional UI colors for Neovim
    border = '#d2d2d2',
    selection = '#3584e4',
    search = '#e5a50a',
    match_paren = '#1c71d8',
    comment = '#5e5e5e',
    cursor_line = '#f0f0f0',
    cursor_column = '#f0f0f0',
    visual = '#3584e4',
    line_nr = '#8b8b8b',
    cursor_line_nr = '#1c71d8',
    sign_column = '#fafafa',
    fold_column = '#8b8b8b',
    pmenu = '#ffffff',
    pmenu_sel = '#3584e4',
    pmenu_sbar = '#d2d2d2',
    pmenu_thumb = '#a9a9a9',
    status_line = '#ffffff',
    status_line_nc = '#f0f0f0',
    tab_line = '#f0f0f0',
    tab_line_sel = '#ffffff',
    tab_line_fill = '#fafafa',
  }
}

-- Adjust rgba values for terminal compatibility
local function adjust_rgba(color)
  if color == 'rgba(0, 0, 0, 0.8)' then
    return is_dark and '#e0e0e0' or '#333333'
  elseif color == 'rgba(0, 0, 0, 0.6)' then
    return is_dark and '#b0b0b0' or '#555555'
  elseif color == 'rgba(255, 255, 255, 0.8)' then
    return is_dark and '#e0e0e0' or '#333333'
  end
  return color
end

-- Select the appropriate color palette
local colors = is_dark and adwaita_colors.dark or adwaita_colors.light

-- Adjust all rgba values for terminal compatibility
for key, value in pairs(colors) do
  colors[key] = adjust_rgba(value)
end

-- Helper function to set highlights
local function hl(group, opts)
  local final_opts = {}
  for k, v in pairs(opts) do
    if k == 'fg' or k == 'bg' or k == 'sp' then
      final_opts[k] = adjust_rgba(v)
    else
      final_opts[k] = v
    end
  end
  vim.api.nvim_set_hl(0, group, final_opts)
end

-- Editor highlights
hl('Normal', { fg = colors.view_fg, bg = colors.view_bg })
hl('NormalNC', { fg = colors.view_fg, bg = colors.view_bg })
hl('NormalFloat', { fg = colors.view_fg, bg = colors.view_bg })
hl('FloatBorder', { fg = colors.border, bg = colors.view_bg })
hl('FloatTitle', { fg = colors.accent, bg = colors.view_bg, bold = true })

-- Cursor and selections
hl('Cursor', { fg = colors.view_bg, bg = colors.view_fg })
hl('CursorLine', { bg = colors.cursor_line })
hl('CursorColumn', { bg = colors.cursor_column })
hl('Visual', { bg = colors.visual })
hl('VisualNOS', { bg = colors.visual })

-- Line numbers and signs
hl('LineNr', { fg = colors.line_nr })
hl('CursorLineNr', { fg = colors.cursor_line_nr, bold = true })
hl('SignColumn', { bg = colors.sign_column })
hl('FoldColumn', { fg = colors.fold_column, bg = colors.view_bg })

-- Folds and diffs
hl('Folded', { fg = colors.comment, bg = colors.view_bg })
hl('DiffAdd', { fg = colors.success_fg, bg = colors.success_bg })
hl('DiffChange', { fg = colors.warning_fg, bg = colors.warning_bg })
hl('DiffDelete', { fg = colors.destructive_fg, bg = colors.destructive_bg })
hl('DiffText', { fg = colors.view_fg, bg = colors.accent_bg })

-- Search
hl('Search', { fg = colors.view_bg, bg = colors.search })
hl('IncSearch', { fg = colors.view_bg, bg = colors.warning })
hl('Substitute', { fg = colors.view_bg, bg = colors.warning_bg })

-- Messages and command line
hl('ModeMsg', { fg = colors.success, bold = true })
hl('MoreMsg', { fg = colors.accent, bold = true })
hl('Question', { fg = colors.accent })
hl('ErrorMsg', { fg = colors.error_fg, bg = colors.error_bg })
hl('WarningMsg', { fg = colors.warning_fg, bg = colors.warning_bg })

-- Statusline and tabline
hl('StatusLine', { fg = colors.headerbar_fg, bg = colors.status_line })
hl('StatusLineNC', { fg = colors.comment, bg = colors.status_line_nc })
hl('TabLine', { fg = colors.comment, bg = colors.tab_line })
hl('TabLineSel', { fg = colors.headerbar_fg, bg = colors.tab_line_sel, bold = true })
hl('TabLineFill', { bg = colors.tab_line_fill })

-- Popup menu
hl('Pmenu', { fg = colors.view_fg, bg = colors.pmenu })
hl('PmenuSel', { fg = colors.accent_fg, bg = colors.pmenu_sel })
hl('PmenuSbar', { bg = colors.pmenu_sbar })
hl('PmenuThumb', { bg = colors.pmenu_thumb })
hl('PmenuKind', { fg = colors.accent, bg = colors.pmenu })
hl('PmenuKindSel', { fg = colors.accent_fg, bg = colors.pmenu_sel })
hl('PmenuExtra', { fg = colors.comment, bg = colors.pmenu })
hl('PmenuExtraSel', { fg = colors.accent_fg, bg = colors.pmenu_sel })

-- Syntax highlighting
hl('Comment', { fg = colors.comment, italic = true })
hl('Constant', { fg = colors.warning })
hl('String', { fg = colors.success })
hl('Character', { fg = colors.success })
hl('Number', { fg = colors.warning })
hl('Boolean', { fg = colors.warning, bold = true })
hl('Float', { fg = colors.warning })

hl('Identifier', { fg = colors.view_fg })
hl('Function', { fg = colors.accent })

hl('Statement', { fg = colors.destructive, bold = true })
hl('Conditional', { fg = colors.destructive, bold = true })
hl('Repeat', { fg = colors.destructive, bold = true })
hl('Label', { fg = colors.warning })
hl('Operator', { fg = colors.accent })
hl('Keyword', { fg = colors.destructive, bold = true })
hl('Exception', { fg = colors.destructive, bold = true })

hl('PreProc', { fg = colors.warning })
hl('Include', { fg = colors.destructive })
hl('Define', { fg = colors.destructive })
hl('Macro', { fg = colors.warning })
hl('PreCondit', { fg = colors.warning })

hl('Type', { fg = colors.accent })
hl('StorageClass', { fg = colors.destructive })
hl('Structure', { fg = colors.destructive })
hl('Typedef', { fg = colors.destructive })

hl('Special', { fg = colors.warning })
hl('SpecialChar', { fg = colors.warning })
hl('Tag', { fg = colors.accent })
hl('Delimiter', { fg = colors.accent })
hl('SpecialComment', { fg = colors.comment, italic = true })
hl('Debug', { fg = colors.error })

-- Underlines and errors
hl('Underlined', { fg = colors.accent, underline = true })
hl('Error', { fg = colors.error_fg, bg = colors.error_bg })
hl('Todo', { fg = colors.warning_fg, bg = colors.warning_bg, bold = true })

-- Matching brackets
hl('MatchParen', { fg = colors.view_bg, bg = colors.match_paren, bold = true })

-- Spell checking
hl('SpellBad', { fg = colors.error, undercurl = true, sp = colors.error })
hl('SpellCap', { fg = colors.warning, undercurl = true, sp = colors.warning })
hl('SpellLocal', { fg = colors.accent, undercurl = true, sp = colors.accent })
hl('SpellRare', { fg = colors.success, undercurl = true, sp = colors.success })

-- LSP and diagnostics
hl('DiagnosticError', { fg = colors.error })
hl('DiagnosticWarn', { fg = colors.warning })
hl('DiagnosticInfo', { fg = colors.accent })
hl('DiagnosticHint', { fg = colors.success })

hl('DiagnosticUnderlineError', { undercurl = true, sp = colors.error })
hl('DiagnosticUnderlineWarn', { undercurl = true, sp = colors.warning })
hl('DiagnosticUnderlineInfo', { undercurl = true, sp = colors.accent })
hl('DiagnosticUnderlineHint', { undercurl = true, sp = colors.success })

-- LSP semantic highlighting
hl('@variable', { fg = colors.view_fg })
hl('@variable.builtin', { fg = colors.warning })
hl('@variable.parameter', { fg = colors.view_fg })
hl('@variable.member', { fg = colors.view_fg })

hl('@constant', { fg = colors.warning })
hl('@constant.builtin', { fg = colors.warning, bold = true })
hl('@constant.macro', { fg = colors.warning })

hl('@string', { fg = colors.success })
hl('@string.escape', { fg = colors.warning })
hl('@character', { fg = colors.success })
hl('@number', { fg = colors.warning })
hl('@boolean', { fg = colors.warning, bold = true })

hl('@function', { fg = colors.accent })
hl('@function.builtin', { fg = colors.warning, bold = true })
hl('@function.macro', { fg = colors.warning })
hl('@method', { fg = colors.accent })
hl('@constructor', { fg = colors.destructive })
hl('@parameter', { fg = colors.view_fg })

hl('@keyword', { fg = colors.destructive })
hl('@keyword.function', { fg = colors.destructive })
hl('@keyword.operator', { fg = colors.destructive })
hl('@keyword.return', { fg = colors.destructive })

hl('@type', { fg = colors.accent })
hl('@type.builtin', { fg = colors.warning })
hl('@namespace', { fg = colors.accent })

hl('@tag', { fg = colors.destructive, bold = true })
hl('@tag.attribute', { fg = colors.warning })
hl('@tag.delimiter', { fg = colors.accent })

-- Git signs (for gitsigns.nvim)
hl('GitSignsAdd', { fg = colors.success })
hl('GitSignsChange', { fg = colors.warning })
hl('GitSignsDelete', { fg = colors.error })

-- Telescope (if using)
hl('TelescopeBorder', { fg = colors.border, bg = colors.view_bg })
hl('TelescopeNormal', { fg = colors.view_fg, bg = colors.view_bg })
hl('TelescopeSelection', { fg = colors.accent_fg, bg = colors.pmenu_sel })
hl('TelescopeMatching', { fg = colors.accent, bold = true })
hl('TelescopePromptBorder', { fg = colors.border, bg = colors.view_bg })
hl('TelescopePromptNormal', { fg = colors.view_fg, bg = colors.view_bg })
hl('TelescopeResultsBorder', { fg = colors.border, bg = colors.view_bg })
hl('TelescopeResultsNormal', { fg = colors.view_fg, bg = colors.view_bg })
hl('TelescopePreviewBorder', { fg = colors.border, bg = colors.view_bg })
hl('TelescopePreviewNormal', { fg = colors.view_fg, bg = colors.view_bg })

-- Tree-sitter context
hl('TreesitterContext', { bg = colors.cursor_line, bold = true })

-- Additional LSP and popup highlights for consistency
hl('LspInfoBorder', { fg = colors.border, bg = colors.view_bg })
hl('LspInfoTitle', { fg = colors.accent, bg = colors.view_bg, bold = true })

-- Which-key popup
hl('WhichKey', { fg = colors.warning })
hl('WhichKeyGroup', { fg = colors.destructive })
hl('WhichKeyDesc', { fg = colors.accent })
hl('WhichKeySeparator', { fg = colors.comment })
hl('WhichKeyFloat', { bg = colors.view_bg })
hl('WhichKeyBorder', { fg = colors.border, bg = colors.view_bg })

-- Notify plugin
hl('NotifyBackground', { bg = colors.view_bg })
hl('NotifyERRORBorder', { fg = colors.error, bg = colors.view_bg })
hl('NotifyWARNBorder', { fg = colors.warning, bg = colors.view_bg })
hl('NotifyINFOBorder', { fg = colors.accent, bg = colors.view_bg })
hl('NotifyDEBUGBorder', { fg = colors.comment, bg = colors.view_bg })
hl('NotifyTRACEBorder', { fg = colors.view_fg, bg = colors.view_bg })

-- Mason (LSP installer)
hl('MasonNormal', { fg = colors.view_fg, bg = colors.view_bg })
hl('MasonHeader', { fg = colors.accent_fg, bg = colors.accent_bg, bold = true })
hl('MasonHeaderSecondary', { fg = colors.accent_fg, bg = colors.warning_bg, bold = true })
hl('MasonHighlight', { fg = colors.accent })
hl('MasonHighlightBlock', { fg = colors.accent_fg, bg = colors.accent_bg })
hl('MasonHighlightBlockBold', { fg = colors.accent_fg, bg = colors.accent_bg, bold = true })
hl('MasonMuted', { fg = colors.comment })
hl('MasonMutedBlock', { fg = colors.comment, bg = colors.cursor_line })

-- Lazy plugin manager
hl('LazyNormal', { fg = colors.view_fg, bg = colors.view_bg })
hl('LazyButton', { fg = colors.view_fg, bg = colors.cursor_line })
hl('LazyButtonActive', { fg = colors.accent_fg, bg = colors.accent_bg, bold = true })
hl('LazyH1', { fg = colors.accent_fg, bg = colors.accent_bg, bold = true })
hl('LazyH2', { fg = colors.accent, bold = true })
hl('LazySpecial', { fg = colors.destructive })
hl('LazyCommit', { fg = colors.success })
hl('LazyReasonPlugin', { fg = colors.destructive })
hl('LazyReasonRuntime', { fg = colors.warning })
hl('LazyReasonCmd', { fg = colors.accent })
hl('LazyReasonEvent', { fg = colors.warning })
hl('LazyReasonKeys', { fg = colors.destructive })

-- Completion item kinds (nvim-cmp)
hl('CmpItemMenu', { fg = colors.comment, bg = colors.view_bg })
hl('CmpItemAbbrDeprecated', { fg = colors.comment, bg = colors.view_bg, strikethrough = true })
hl('CmpItemAbbrMatch', { fg = colors.accent, bg = colors.view_bg, bold = true })
hl('CmpItemAbbrMatchFuzzy', { fg = colors.accent, bg = colors.view_bg, bold = true })
hl('CmpItemKindVariable', { fg = colors.view_fg, bg = colors.view_bg })
hl('CmpItemKindInterface', { fg = colors.accent, bg = colors.view_bg })
hl('CmpItemKindText', { fg = colors.view_fg, bg = colors.view_bg })
hl('CmpItemKindFunction', { fg = colors.accent, bg = colors.view_bg })
hl('CmpItemKindMethod', { fg = colors.accent, bg = colors.view_bg })
hl('CmpItemKindKeyword', { fg = colors.destructive, bg = colors.view_bg })
hl('CmpItemKindProperty', { fg = colors.view_fg, bg = colors.view_bg })
hl('CmpItemKindUnit', { fg = colors.warning, bg = colors.view_bg })

-- Enhanced Tree-sitter highlights for common languages
hl('@field', { fg = colors.view_fg })
hl('@property', { fg = colors.view_fg })
hl('@string', { fg = colors.success })
hl('@number', { fg = colors.warning })
hl('@boolean', { fg = colors.warning, bold = true })
hl('@constant', { fg = colors.warning })
hl('@constant.builtin', { fg = colors.warning, bold = true })
hl('@function', { fg = colors.accent })
hl('@function.builtin', { fg = colors.warning, bold = true })
hl('@method', { fg = colors.accent })
hl('@constructor', { fg = colors.destructive })
hl('@keyword', { fg = colors.destructive })
hl('@keyword.function', { fg = colors.destructive })
hl('@keyword.return', { fg = colors.destructive })
hl('@type', { fg = colors.accent })
hl('@type.builtin', { fg = colors.warning })
hl('@parameter', { fg = colors.view_fg })
hl('@variable', { fg = colors.view_fg })
hl('@variable.builtin', { fg = colors.warning })
hl('@label', { fg = colors.warning })
hl('@tag', { fg = colors.destructive, bold = true })
hl('@tag.attribute', { fg = colors.warning })
hl('@tag.delimiter', { fg = colors.accent })

-- Markdown highlights
hl('@markup.heading', { fg = colors.accent, bold = true })
hl('@markup.list', { fg = colors.destructive })
hl('@markup.bold', { fg = colors.warning, bold = true })
hl('@markup.italic', { fg = colors.warning, italic = true })
hl('@markup.strikethrough', { fg = colors.destructive, strikethrough = true })
hl('@markup.link', { fg = colors.accent, underline = true })
hl('@markup.link.label', { fg = colors.destructive })
hl('@markup.link.url', { fg = colors.accent, underline = true })
hl('@markup.raw', { fg = colors.success })
hl('@markup.raw.block', { fg = colors.success })

-- YAML highlights
hl('@field.yaml', { fg = colors.view_fg })
hl('@string.yaml', { fg = colors.success })
hl('@number.yaml', { fg = colors.warning })
hl('@boolean.yaml', { fg = colors.warning, bold = true })
hl('@constant.builtin.yaml', { fg = colors.warning })

-- JSON highlights
hl('@field.json', { fg = colors.view_fg })
hl('@string.json', { fg = colors.success })
hl('@number.json', { fg = colors.warning })
hl('@boolean.json', { fg = colors.warning, bold = true })

-- HTML highlights
hl('@tag.html', { fg = colors.destructive, bold = true })
hl('@tag.attribute.html', { fg = colors.warning })
hl('@text.html', { fg = colors.view_fg })

-- CSS highlights
hl('@property.css', { fg = colors.view_fg })
hl('@string.css', { fg = colors.success })
hl('@number.css', { fg = colors.warning })
hl('@function.css', { fg = colors.accent })

-- JavaScript/TypeScript highlights
hl('@function.javascript', { fg = colors.accent })
hl('@function.typescript', { fg = colors.accent })
hl('@method.javascript', { fg = colors.accent })
hl('@method.typescript', { fg = colors.accent })
hl('@constructor.javascript', { fg = colors.destructive })
hl('@constructor.typescript', { fg = colors.destructive })

-- Python highlights
hl('@function.python', { fg = colors.accent })
hl('@method.python', { fg = colors.accent })
hl('@constructor.python', { fg = colors.destructive })
hl('@parameter.python', { fg = colors.view_fg })

-- Go highlights
hl('@function.go', { fg = colors.accent })
hl('@method.go', { fg = colors.accent })
hl('@type.go', { fg = colors.accent })

-- Rust highlights
hl('@function.rust', { fg = colors.accent })
hl('@method.rust', { fg = colors.accent })
hl('@type.rust', { fg = colors.accent })

-- Additional file explorer highlights
hl('NvimTreeNormal', { fg = colors.view_fg, bg = colors.view_bg })
hl('NvimTreeGitDirty', { fg = colors.warning })
hl('NvimTreeGitStaged', { fg = colors.success })
hl('NvimTreeGitMerge', { fg = colors.destructive })
hl('NvimTreeGitNew', { fg = colors.success })
hl('NvimTreeGitDeleted', { fg = colors.error })

hl('NeoTreeNormal', { fg = colors.view_fg, bg = colors.view_bg })
hl('NeoTreeGitModified', { fg = colors.warning })
hl('NeoTreeGitAdded', { fg = colors.success })
hl('NeoTreeGitDeleted', { fg = colors.error })

-- LspReference highlighting for plugins like LspTrouble
hl('LspReferenceText', { bg = colors.cursor_line })
hl('LspReferenceRead', { bg = colors.cursor_line })
hl('LspReferenceWrite', { bg = colors.cursor_line })

-- Indent guides (for indent-blankline.nvim)
hl('IndentBlanklineChar', { fg = colors.border, nocombine = true })
hl('IndentBlanklineContextChar', { fg = colors.comment, nocombine = true })

-- Cursor word highlighting (for plugins like cursorword.nvim)
hl('CursorWord', { bg = colors.cursor_line })

-- Quickfix highlights
hl('qfLineNr', { fg = colors.accent })
hl('qfFileName', { fg = colors.warning })

-- Sign column highlights
hl('SignColumn', { fg = colors.view_fg, bg = colors.sign_column })

-- Whitespace characters
hl('Whitespace', { fg = colors.border })

-- NonText characters
hl('NonText', { fg = colors.comment })

-- Special key characters
hl('SpecialKey', { fg = colors.comment })

-- Terminal colors
vim.g.terminal_color_0 = colors.view_bg
vim.g.terminal_color_1 = colors.error
vim.g.terminal_color_2 = colors.success
vim.g.terminal_color_3 = colors.warning
vim.g.terminal_color_4 = colors.accent
vim.g.terminal_color_5 = colors.destructive
vim.g.terminal_color_6 = colors.accent
vim.g.terminal_color_7 = colors.view_fg
vim.g.terminal_color_8 = colors.comment
vim.g.terminal_color_9 = colors.error
vim.g.terminal_color_10 = colors.success
vim.g.terminal_color_11 = colors.warning
vim.g.terminal_color_12 = colors.accent
vim.g.terminal_color_13 = colors.destructive
vim.g.terminal_color_14 = colors.accent
vim.g.terminal_color_15 = colors.view_fg

  -- Apply the colorscheme
  vim.cmd('syntax reset')
  vim.o.background = is_dark and 'dark' or 'light'
end

-- Call setup function to apply the colorscheme
M.setup()