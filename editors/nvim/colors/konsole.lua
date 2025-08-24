-- konsole.lua
-- A custom Neovim colorscheme designed for KDE Konsole terminal (#232627)

-- Clear existing highlights
vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd 'syntax reset'
end

vim.o.termguicolors = true
vim.g.colors_name = 'konsole_dark'

-- Color palette inspired by and harmonizing with Konsole background #232627
local colors = {
  -- Base colors matching Konsole theme
  bg = '#232627', -- Main background (matches Konsole)
  bg_alt = '#2a2e32', -- Slightly lighter background
  bg_light = '#31363b', -- Lighter background for selections

  fg = '#eff0f1', -- Main foreground (light gray)
  fg_alt = '#bdc3c7', -- Dimmer foreground
  fg_dark = '#7f8c8d', -- Dark foreground for comments

  -- Accent colors that complement the blue-gray base
  blue = '#3daee9', -- KDE blue accent
  cyan = '#16a085', -- Teal cyan
  green = '#37ad82', -- Fresh green (inspired by sitruuna)
  yellow = '#FAC03B', -- Bright lemon yellow (from sitruuna)
  orange = '#ffb354', -- Warm orange (from sitruuna)
  red = '#c15959', -- Soft red (from sitruuna)
  coral = '#ca70d6', -- Coral/pink (replacing purple, from sitruuna)
  magenta = '#a29bfe', -- Light lavender (from sitruuna)

  -- UI colors
  border = '#34495e', -- Borders and separators
  selection = '#34495e', -- Visual selections
  search = '#f39c12', -- Search highlights
  match_paren = '#3daee9', -- Matching parentheses

  -- Git colors
  git_add = '#37ad82', -- Added lines (sitruuna green)
  git_change = '#FAC03B', -- Changed lines (sitruuna yellow)
  git_delete = '#c15959', -- Deleted lines (sitruuna red)

  -- Diagnostic colors
  error = '#c15959',
  warning = '#FAC03B',
  info = '#3daee9',
  hint = '#16a085',
}

-- Helper function to set highlights
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor highlights
hl('Normal', { fg = colors.fg, bg = colors.bg })
hl('NormalNC', { fg = colors.fg, bg = colors.bg })
hl('NormalFloat', { fg = colors.fg, bg = colors.bg })
hl('FloatBorder', { fg = colors.border, bg = colors.bg })
hl('FloatTitle', { fg = colors.blue, bg = colors.bg })

-- Cursor and selections
hl('Cursor', { fg = colors.bg, bg = colors.fg })
hl('CursorLine', { bg = colors.bg_light })
hl('CursorColumn', { bg = colors.bg_light })
hl('Visual', { bg = colors.selection })
hl('VisualNOS', { bg = colors.selection })

-- Line numbers and signs
hl('LineNr', { fg = colors.fg_dark })
hl('CursorLineNr', { fg = colors.blue, bold = true })
hl('SignColumn', { bg = colors.bg })
hl('FoldColumn', { fg = colors.fg_dark, bg = colors.bg })

-- Folds and diffs
hl('Folded', { fg = colors.fg_alt, bg = colors.bg_alt })
hl('DiffAdd', { fg = colors.git_add, bg = colors.bg })
hl('DiffChange', { fg = colors.git_change, bg = colors.bg })
hl('DiffDelete', { fg = colors.git_delete, bg = colors.bg })
hl('DiffText', { fg = colors.fg, bg = colors.git_change })

-- Search
hl('Search', { fg = colors.bg, bg = colors.yellow })
hl('IncSearch', { fg = colors.bg, bg = colors.orange })
hl('Substitute', { fg = colors.bg, bg = colors.coral })

-- Messages and command line
hl('ModeMsg', { fg = colors.green, bold = true })
hl('MoreMsg', { fg = colors.cyan })
hl('Question', { fg = colors.blue })
hl('ErrorMsg', { fg = colors.error })
hl('WarningMsg', { fg = colors.warning })

-- Statusline and tabline
hl('StatusLine', { fg = colors.fg, bg = colors.bg_alt })
hl('StatusLineNC', { fg = colors.fg_dark, bg = colors.bg_alt })
hl('TabLine', { fg = colors.fg_alt, bg = colors.bg_alt })
hl('TabLineSel', { fg = colors.fg, bg = colors.bg })
hl('TabLineFill', { bg = colors.bg_alt })

-- Popup menu
hl('Pmenu', { fg = colors.fg, bg = colors.bg })
hl('PmenuSel', { fg = colors.bg, bg = colors.blue })
hl('PmenuSbar', { bg = colors.bg_light })
hl('PmenuThumb', { bg = colors.border })
hl('PmenuKind', { fg = colors.yellow, bg = colors.bg })
hl('PmenuKindSel', { fg = colors.bg, bg = colors.blue })
hl('PmenuExtra', { fg = colors.fg_alt, bg = colors.bg })
hl('PmenuExtraSel', { fg = colors.bg, bg = colors.blue })

-- Syntax highlighting
hl('Comment', { fg = colors.fg_dark, italic = true })
hl('Constant', { fg = colors.red })
hl('String', { fg = colors.green })
hl('Character', { fg = colors.green })
hl('Number', { fg = colors.red })
hl('Boolean', { fg = colors.red })
hl('Float', { fg = colors.red })

hl('Identifier', { fg = colors.cyan })
hl('Function', { fg = colors.blue })

hl('Statement', { fg = colors.coral })
hl('Conditional', { fg = colors.coral })
hl('Repeat', { fg = colors.coral })
hl('Label', { fg = colors.coral })
hl('Operator', { fg = colors.fg })
hl('Keyword', { fg = colors.coral })
hl('Exception', { fg = colors.coral })

hl('PreProc', { fg = colors.magenta })
hl('Include', { fg = colors.coral })
hl('Define', { fg = colors.coral })
hl('Macro', { fg = colors.magenta })
hl('PreCondit', { fg = colors.magenta })

hl('Type', { fg = colors.yellow })
hl('StorageClass', { fg = colors.yellow })
hl('Structure', { fg = colors.yellow })
hl('Typedef', { fg = colors.yellow })

hl('Special', { fg = colors.orange })
hl('SpecialChar', { fg = colors.orange })
hl('Tag', { fg = colors.blue })
hl('Delimiter', { fg = colors.fg_alt })
hl('SpecialComment', { fg = colors.cyan, italic = true })
hl('Debug', { fg = colors.red })

-- Underlines and errors
hl('Underlined', { fg = colors.blue, underline = true })
hl('Error', { fg = colors.error })
hl('Todo', { fg = colors.yellow, bg = colors.bg, bold = true })

-- Matching brackets
hl('MatchParen', { fg = colors.match_paren, bold = true })

-- Spell checking
hl('SpellBad', { fg = colors.error, underline = true })
hl('SpellCap', { fg = colors.warning, underline = true })
hl('SpellLocal', { fg = colors.info, underline = true })
hl('SpellRare', { fg = colors.hint, underline = true })

-- LSP and diagnostics
hl('DiagnosticError', { fg = colors.error })
hl('DiagnosticWarn', { fg = colors.warning })
hl('DiagnosticInfo', { fg = colors.info })
hl('DiagnosticHint', { fg = colors.hint })

hl('DiagnosticUnderlineError', { underline = true, sp = colors.error })
hl('DiagnosticUnderlineWarn', { underline = true, sp = colors.warning })
hl('DiagnosticUnderlineInfo', { underline = true, sp = colors.info })
hl('DiagnosticUnderlineHint', { underline = true, sp = colors.hint })

-- LSP semantic highlighting
hl('@variable', { fg = colors.fg })
hl('@variable.builtin', { fg = colors.red })
hl('@variable.parameter', { fg = colors.fg_alt })
hl('@variable.member', { fg = colors.cyan })

hl('@constant', { fg = colors.red })
hl('@constant.builtin', { fg = colors.red })
hl('@constant.macro', { fg = colors.yellow })

hl('@string', { fg = colors.green })
hl('@string.escape', { fg = colors.orange })
hl('@character', { fg = colors.green })
hl('@number', { fg = colors.red })
hl('@boolean', { fg = colors.red })

hl('@function', { fg = colors.blue })
hl('@function.builtin', { fg = colors.blue })
hl('@function.macro', { fg = colors.magenta })
hl('@method', { fg = colors.blue })
hl('@constructor', { fg = colors.yellow })

hl('@keyword', { fg = colors.coral })
hl('@keyword.function', { fg = colors.coral })
hl('@keyword.operator', { fg = colors.coral })
hl('@keyword.return', { fg = colors.coral })

hl('@type', { fg = colors.yellow })
hl('@type.builtin', { fg = colors.yellow })
hl('@namespace', { fg = colors.cyan })

hl('@tag', { fg = colors.blue })
hl('@tag.attribute', { fg = colors.cyan })
hl('@tag.delimiter', { fg = colors.fg_alt })

-- Git signs (for gitsigns.nvim)
hl('GitSignsAdd', { fg = colors.git_add })
hl('GitSignsChange', { fg = colors.git_change })
hl('GitSignsDelete', { fg = colors.git_delete })

-- Telescope (if using)
hl('TelescopeBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopeNormal', { fg = colors.fg, bg = colors.bg })
hl('TelescopeSelection', { bg = colors.selection })
hl('TelescopeMatching', { fg = colors.search })
hl('TelescopePromptBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopePromptNormal', { fg = colors.fg, bg = colors.bg })
hl('TelescopeResultsBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopeResultsNormal', { fg = colors.fg, bg = colors.bg })
hl('TelescopePreviewBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopePreviewNormal', { fg = colors.fg, bg = colors.bg })

-- Tree-sitter context
hl('TreesitterContext', { bg = colors.bg_alt })
hl('TreesitterContextLineNumber', { fg = colors.fg_dark, bg = colors.bg_alt })

-- Additional LSP and popup highlights for consistency
hl('LspInfoBorder', { fg = colors.border, bg = colors.bg })
hl('LspInfoTitle', { fg = colors.blue, bg = colors.bg })

-- Which-key popup
hl('WhichKey', { fg = colors.blue })
hl('WhichKeyGroup', { fg = colors.coral })
hl('WhichKeyDesc', { fg = colors.fg })
hl('WhichKeySeperator', { fg = colors.fg_dark })
hl('WhichKeyFloat', { bg = colors.bg })
hl('WhichKeyBorder', { fg = colors.border, bg = colors.bg })

-- Notify plugin
hl('NotifyBackground', { bg = colors.bg })
hl('NotifyERRORBorder', { fg = colors.error, bg = colors.bg })
hl('NotifyWARNBorder', { fg = colors.warning, bg = colors.bg })
hl('NotifyINFOBorder', { fg = colors.info, bg = colors.bg })
hl('NotifyDEBUGBorder', { fg = colors.hint, bg = colors.bg })
hl('NotifyTRACEBorder', { fg = colors.fg_alt, bg = colors.bg })

-- Mason (LSP installer)
hl('MasonNormal', { fg = colors.fg, bg = colors.bg })
hl('MasonHeader', { fg = colors.bg, bg = colors.blue, bold = true })
hl('MasonHeaderSecondary', { fg = colors.bg, bg = colors.coral, bold = true })
hl('MasonHighlight', { fg = colors.blue })
hl('MasonHighlightBlock', { fg = colors.bg, bg = colors.blue })
hl('MasonHighlightBlockBold', { fg = colors.bg, bg = colors.blue, bold = true })
hl('MasonMuted', { fg = colors.fg_dark })
hl('MasonMutedBlock', { fg = colors.fg_alt, bg = colors.bg_light })

-- Lazy plugin manager
hl('LazyNormal', { fg = colors.fg, bg = colors.bg })
hl('LazyButton', { fg = colors.fg_alt, bg = colors.bg_light })
hl('LazyButtonActive', { fg = colors.bg, bg = colors.blue, bold = true })
hl('LazyH1', { fg = colors.bg, bg = colors.blue, bold = true })
hl('LazyH2', { fg = colors.blue, bold = true })
hl('LazySpecial', { fg = colors.coral })
hl('LazyCommit', { fg = colors.green })
hl('LazyReasonPlugin', { fg = colors.coral })
hl('LazyReasonRuntime', { fg = colors.yellow })
hl('LazyReasonCmd', { fg = colors.cyan })
hl('LazyReasonEvent', { fg = colors.orange })
hl('LazyReasonKeys', { fg = colors.magenta })

-- Completion item kinds (nvim-cmp)
hl('CmpItemMenu', { fg = colors.fg_alt, bg = colors.bg })
hl('CmpItemAbbrDeprecated', { fg = colors.fg_dark, bg = colors.bg, strikethrough = true })
hl('CmpItemAbbrMatch', { fg = colors.blue, bg = colors.bg, bold = true })
hl('CmpItemAbbrMatchFuzzy', { fg = colors.blue, bg = colors.bg, bold = true })
hl('CmpItemKindVariable', { fg = colors.cyan, bg = colors.bg })
hl('CmpItemKindInterface', { fg = colors.cyan, bg = colors.bg })
hl('CmpItemKindText', { fg = colors.fg, bg = colors.bg })
hl('CmpItemKindFunction', { fg = colors.blue, bg = colors.bg })
hl('CmpItemKindMethod', { fg = colors.blue, bg = colors.bg })
hl('CmpItemKindKeyword', { fg = colors.coral, bg = colors.bg })
hl('CmpItemKindProperty', { fg = colors.cyan, bg = colors.bg })
hl('CmpItemKindUnit', { fg = colors.yellow, bg = colors.bg })
