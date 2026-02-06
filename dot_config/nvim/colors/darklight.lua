-- Dark Light colorscheme for Neovim
-- Save as: ~/.config/nvim/colors/darklight.lua
-- To use: Add `vim.cmd('colorscheme darklight')` to your init.lua

local M = {}

-- Clear existing highlights
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'darklight'
vim.o.termguicolors = true

-- Color palette - light and vibrant for readability
local colors = {
  bg = '#232627',
  bg_light = '#2d3234',
  bg_lighter = '#363b3d',
  bg_float = '#1e2021',
  
  fg = '#e8e8e8',
  fg_dim = '#b8b8b8',
  fg_dimmer = '#909090',
  
  -- Vibrant colors for syntax
  cyan = '#6eccdd',
  blue = '#5fa7e4',
  purple = '#b57bdb',
  magenta = '#d98fd8',
  red = '#ef6b73',
  orange = '#f99157',
  yellow = '#f9d857',
  green = '#8bd88b',
  teal = '#5fb3b3',
  
  -- UI colors
  selection = '#3d4547',
  visual = '#445558',
  search = '#4a5c63',
  line_highlight = '#2a2d2f',
  cursor_line = '#2d3234',
  
  -- Status colors
  error = '#ef6b73',
  warning = '#f9d857',
  info = '#6eccdd',
  hint = '#8bd88b',
  
  -- Borders and separators
  border = '#3d4547',
  comment = '#6b7477',
}

-- Helper function to set highlights
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor highlights
hl('Normal', { fg = colors.fg, bg = colors.bg })
hl('NormalFloat', { fg = colors.fg, bg = colors.bg_float })
hl('FloatBorder', { fg = colors.border, bg = colors.bg_float })
hl('CursorLine', { bg = colors.cursor_line })
hl('CursorLineNr', { fg = colors.yellow, bold = true })
hl('LineNr', { fg = colors.fg_dimmer })
hl('SignColumn', { bg = colors.bg })
hl('Visual', { bg = colors.visual })
hl('VisualNOS', { bg = colors.visual })
hl('Search', { bg = colors.search, fg = colors.fg })
hl('IncSearch', { bg = colors.orange, fg = colors.bg })
hl('Pmenu', { fg = colors.fg, bg = colors.bg_light })
hl('PmenuSel', { fg = colors.fg, bg = colors.visual, bold = true })
hl('PmenuSbar', { bg = colors.bg_lighter })
hl('PmenuThumb', { bg = colors.fg_dim })
hl('StatusLine', { fg = colors.fg, bg = colors.bg_light })
hl('StatusLineNC', { fg = colors.fg_dimmer, bg = colors.bg_light })
hl('TabLine', { fg = colors.fg_dim, bg = colors.bg_light })
hl('TabLineSel', { fg = colors.fg, bg = colors.bg, bold = true })
hl('TabLineFill', { bg = colors.bg_light })
hl('VertSplit', { fg = colors.border })
hl('WinSeparator', { fg = colors.border })
hl('Folded', { fg = colors.comment, bg = colors.bg_light })
hl('FoldColumn', { fg = colors.comment, bg = colors.bg })
hl('ColorColumn', { bg = colors.bg_light })
hl('MatchParen', { fg = colors.orange, bold = true, underline = true })

-- Syntax highlighting
hl('Comment', { fg = colors.comment, italic = true })
hl('Constant', { fg = colors.orange })
hl('String', { fg = colors.green })
hl('Character', { fg = colors.green })
hl('Number', { fg = colors.orange })
hl('Boolean', { fg = colors.orange })
hl('Float', { fg = colors.orange })
hl('Identifier', { fg = colors.cyan })
hl('Function', { fg = colors.blue, bold = true })
hl('Statement', { fg = colors.purple })
hl('Conditional', { fg = colors.purple })
hl('Repeat', { fg = colors.purple })
hl('Label', { fg = colors.purple })
hl('Operator', { fg = colors.fg })
hl('Keyword', { fg = colors.purple, bold = true })
hl('Exception', { fg = colors.red })
hl('PreProc', { fg = colors.magenta })
hl('Include', { fg = colors.magenta })
hl('Define', { fg = colors.magenta })
hl('Macro', { fg = colors.magenta })
hl('PreCondit', { fg = colors.magenta })
hl('Type', { fg = colors.yellow })
hl('StorageClass', { fg = colors.yellow })
hl('Structure', { fg = colors.yellow })
hl('Typedef', { fg = colors.yellow })
hl('Special', { fg = colors.cyan })
hl('SpecialChar', { fg = colors.cyan })
hl('Tag', { fg = colors.cyan })
hl('Delimiter', { fg = colors.fg_dim })
hl('SpecialComment', { fg = colors.comment, bold = true })
hl('Debug', { fg = colors.red })
hl('Underlined', { underline = true })
hl('Ignore', { fg = colors.comment })
hl('Error', { fg = colors.error, bold = true })
hl('Todo', { fg = colors.warning, bold = true })

-- Treesitter highlights
-- General
hl('@variable', { fg = colors.fg })
hl('@variable.builtin', { fg = colors.red, italic = true })
hl('@variable.parameter', { fg = colors.cyan })
hl('@variable.member', { fg = colors.cyan })
hl('@constant', { fg = colors.orange })
hl('@constant.builtin', { fg = colors.orange, bold = true })
hl('@module', { fg = colors.yellow })
hl('@label', { fg = colors.purple })

-- Functions and methods
hl('@function', { fg = colors.blue, bold = true })
hl('@function.builtin', { fg = colors.blue, italic = true })
hl('@function.method', { fg = colors.blue })
hl('@constructor', { fg = colors.yellow })

-- Keywords
hl('@keyword', { fg = colors.purple, bold = true })
hl('@keyword.function', { fg = colors.purple, bold = true })
hl('@keyword.return', { fg = colors.purple, bold = true })
hl('@keyword.operator', { fg = colors.purple })
hl('@keyword.import', { fg = colors.magenta })
hl('@keyword.conditional', { fg = colors.purple })
hl('@keyword.repeat', { fg = colors.purple })
hl('@keyword.exception', { fg = colors.red })

-- Operators and punctuation
hl('@operator', { fg = colors.fg })
hl('@punctuation.delimiter', { fg = colors.fg_dim })
hl('@punctuation.bracket', { fg = colors.fg })
hl('@punctuation.special', { fg = colors.cyan })

-- Types
hl('@type', { fg = colors.yellow })
hl('@type.builtin', { fg = colors.yellow, bold = true })
hl('@type.definition', { fg = colors.yellow })
hl('@type.qualifier', { fg = colors.purple })

-- Strings and text
hl('@string', { fg = colors.green })
hl('@string.escape', { fg = colors.cyan })
hl('@string.special', { fg = colors.cyan })
hl('@character', { fg = colors.green })
hl('@number', { fg = colors.orange })
hl('@boolean', { fg = colors.orange })
hl('@float', { fg = colors.orange })

-- Comments
hl('@comment', { fg = colors.comment, italic = true })
hl('@comment.documentation', { fg = colors.comment, italic = true })

-- Markup (for markdown, etc.)
hl('@markup.heading', { fg = colors.blue, bold = true })
hl('@markup.emphasis', { italic = true })
hl('@markup.strong', { bold = true })
hl('@markup.link', { fg = colors.cyan, underline = true })
hl('@markup.list', { fg = colors.purple })

-- Python specific
hl('@variable.python', { fg = colors.fg })
hl('@function.call.python', { fg = colors.blue })
hl('@keyword.python', { fg = colors.purple, bold = true })
hl('@type.python', { fg = colors.yellow })
hl('@decorator.python', { fg = colors.magenta })
hl('@string.documentation.python', { fg = colors.comment, italic = true })

-- Rust specific
hl('@lsp.type.macro.rust', { fg = colors.magenta, bold = true })
hl('@keyword.rust', { fg = colors.purple, bold = true })
hl('@type.rust', { fg = colors.yellow })
hl('@namespace.rust', { fg = colors.yellow })
hl('@attribute.rust', { fg = colors.magenta })

-- C# specific
hl('@keyword.c_sharp', { fg = colors.purple, bold = true })
hl('@type.c_sharp', { fg = colors.yellow })
hl('@namespace.c_sharp', { fg = colors.yellow })
hl('@attribute.c_sharp', { fg = colors.magenta })

-- YAML specific
hl('@field.yaml', { fg = colors.blue })
hl('@string.yaml', { fg = colors.green })
hl('@punctuation.delimiter.yaml', { fg = colors.fg_dim })

-- JSON specific
hl('@label.json', { fg = colors.blue })
hl('@string.json', { fg = colors.green })

-- TOML specific
hl('@property.toml', { fg = colors.blue })
hl('@string.toml', { fg = colors.green })

-- Dockerfile specific
hl('@keyword.dockerfile', { fg = colors.purple, bold = true })
hl('@string.dockerfile', { fg = colors.green })

-- Diagnostics
hl('DiagnosticError', { fg = colors.error })
hl('DiagnosticWarn', { fg = colors.warning })
hl('DiagnosticInfo', { fg = colors.info })
hl('DiagnosticHint', { fg = colors.hint })
hl('DiagnosticUnderlineError', { sp = colors.error, undercurl = true })
hl('DiagnosticUnderlineWarn', { sp = colors.warning, undercurl = true })
hl('DiagnosticUnderlineInfo', { sp = colors.info, undercurl = true })
hl('DiagnosticUnderlineHint', { sp = colors.hint, undercurl = true })

-- LSP
hl('LspReferenceText', { bg = colors.selection })
hl('LspReferenceRead', { bg = colors.selection })
hl('LspReferenceWrite', { bg = colors.selection })
hl('LspSignatureActiveParameter', { fg = colors.orange, bold = true })

-- Git signs
hl('GitSignsAdd', { fg = colors.green })
hl('GitSignsChange', { fg = colors.yellow })
hl('GitSignsDelete', { fg = colors.red })

-- Telescope
hl('TelescopeBorder', { fg = colors.border, bg = colors.bg_float })
hl('TelescopeNormal', { fg = colors.fg, bg = colors.bg_float })
hl('TelescopeSelection', { fg = colors.fg, bg = colors.visual })
hl('TelescopeMatching', { fg = colors.cyan, bold = true })

-- LazyVim specific
hl('LazyNormal', { fg = colors.fg, bg = colors.bg_float })
hl('LazyButton', { fg = colors.fg, bg = colors.bg_lighter })
hl('LazyButtonActive', { fg = colors.fg, bg = colors.visual, bold = true })
hl('LazyH1', { fg = colors.blue, bold = true })
hl('LazyH2', { fg = colors.cyan })
hl('LazySpecial', { fg = colors.magenta })
hl('LazyCommit', { fg = colors.green })
hl('LazyReasonPlugin', { fg = colors.cyan })
hl('LazyReasonRuntime', { fg = colors.purple })
hl('LazyReasonCmd', { fg = colors.yellow })
hl('LazyReasonSource', { fg = colors.orange })

-- Mini.files specific
hl('MiniFilesDirectory', { fg = colors.blue, bold = true })
hl('MiniFilesFile', { fg = colors.fg })
hl('MiniFilesTitleFocused', { fg = colors.cyan, bg = colors.bg_light, bold = true })
hl('MiniFilesTitle', { fg = colors.fg_dim, bg = colors.bg_light })
hl('MiniFilesBorder', { fg = colors.border, bg = colors.bg_float })
hl('MiniFilesBorderModified', { fg = colors.warning, bg = colors.bg_float })
hl('MiniFilesNormal', { fg = colors.fg, bg = colors.bg_float })
hl('MiniFilesCursorLine', { bg = colors.visual })

-- WhichKey
hl('WhichKey', { fg = colors.cyan })
hl('WhichKeyGroup', { fg = colors.blue })
hl('WhichKeyDesc', { fg = colors.fg })
hl('WhichKeySeparator', { fg = colors.comment })
hl('WhichKeyFloat', { bg = colors.bg_float })
hl('WhichKeyBorder', { fg = colors.border, bg = colors.bg_float })

-- Neo-tree
hl('NeoTreeNormal', { fg = colors.fg, bg = colors.bg_float })
hl('NeoTreeNormalNC', { fg = colors.fg, bg = colors.bg_float })
hl('NeoTreeDirectoryIcon', { fg = colors.blue })
hl('NeoTreeDirectoryName', { fg = colors.blue })
hl('NeoTreeFileName', { fg = colors.fg })
hl('NeoTreeGitModified', { fg = colors.yellow })
hl('NeoTreeGitAdded', { fg = colors.green })
hl('NeoTreeGitDeleted', { fg = colors.red })

return M
