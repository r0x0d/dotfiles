-- breeze.lua
-- A comprehensive custom Neovim colorscheme designed for KDE Konsole terminal (#232627)
-- Complete coverage of all Neovim highlight groups and extensive language support

-- Clear existing highlights and ensure clean state
vim.cmd('highlight clear')
vim.cmd('syntax reset')

-- Ensure termguicolors is set before any highlights
vim.o.termguicolors = true
vim.g.colors_name = 'breeze'

-- Color palette inspired by and harmonizing with Konsole background #232627
local colors = {
  -- Base colors matching Konsole theme
  bg = '#232627', -- Main background (matches Konsole)
  bg_alt = '#2a2e32', -- Slightly lighter background
  bg_light = '#31363b', -- Lighter background for selections
  bg_dark = '#1d2021', -- Darker background

  fg = '#eff0f1', -- Main foreground (light gray)
  fg_alt = '#bdc3c7', -- Dimmer foreground
  fg_dark = '#7f8c8d', -- Dark foreground for comments
  fg_light = '#ffffff', -- Bright white

  -- Accent colors that complement the blue-gray base
  blue = '#3daee9', -- KDE blue accent
  cyan = '#16a085', -- Teal cyan
  green = '#37ad82', -- Fresh green (inspired by sitruuna)
  yellow = '#FAC03B', -- Bright lemon yellow (from sitruuna)
  orange = '#ffb354', -- Warm orange (from sitruuna)
  red = '#c15959', -- Soft red (from sitruuna)
  coral = '#ca70d6', -- Coral/pink (replacing purple, from sitruuna)
  magenta = '#a29bfe', -- Light lavender (from sitruuna)
  purple = '#9b59b6', -- True purple
  pink = '#e91e63', -- Bright pink

  -- UI colors
  border = '#34495e', -- Borders and separators
  selection = '#34495e', -- Visual selections
  search = '#f39c12', -- Search highlights
  match_paren = '#3daee9', -- Matching parentheses
  cursor_line = '#2c3136', -- Subtle cursor line
  visual_selection = '#3e4451', -- Visual selection

  -- Git colors
  git_add = '#37ad82', -- Added lines (sitruuna green)
  git_change = '#FAC03B', -- Changed lines (sitruuna yellow)
  git_delete = '#c15959', -- Deleted lines (sitruuna red)
  git_untracked = '#95a5a6', -- Untracked files

  -- Diagnostic colors
  error = '#c15959',
  warning = '#FAC03B',
  info = '#3daee9',
  hint = '#16a085',
  ok = '#37ad82',

  -- Special colors
  none = 'NONE',
  transparent = 'NONE',
}

-- Helper function to set highlights with error checking
local function hl(group, opts)
  if type(opts) ~= 'table' then
    opts = {}
  end
  
  -- Convert NONE strings to actual NONE for Neovim
  for key, value in pairs(opts) do
    if value == 'NONE' then
      opts[key] = nil
    end
  end
  
  local success, err = pcall(vim.api.nvim_set_hl, 0, group, opts)
  if not success then
    vim.notify('Error setting highlight for ' .. group .. ': ' .. err, vim.log.levels.WARN)
  end
end

-- ============================================================================
-- CORE NEOVIM HIGHLIGHTS - Essential for proper rendering
-- ============================================================================

-- Base editor highlights
hl('Normal', { fg = colors.fg, bg = colors.bg })
hl('NormalNC', { fg = colors.fg, bg = colors.bg })
hl('NormalFloat', { fg = colors.fg, bg = colors.bg })
hl('NormalSB', { fg = colors.fg, bg = colors.bg_alt })

-- Cursor highlights - critical for preventing flickering
hl('Cursor', { fg = colors.bg, bg = colors.fg, reverse = false })
hl('lCursor', { fg = colors.bg, bg = colors.fg, reverse = false })
hl('CursorIM', { fg = colors.bg, bg = colors.fg, reverse = false })
hl('TermCursor', { fg = colors.bg, bg = colors.fg, reverse = false })
hl('TermCursorNC', { fg = colors.bg, bg = colors.fg_dark, reverse = false })

-- Line and column highlights
hl('CursorLine', { bg = colors.cursor_line, nocombine = true })
hl('CursorColumn', { bg = colors.cursor_line, nocombine = true })
hl('ColorColumn', { bg = colors.bg_light })

-- Visual selection
hl('Visual', { bg = colors.visual_selection, nocombine = true })
hl('VisualNOS', { bg = colors.visual_selection, nocombine = true })

-- Line numbers and columns
hl('LineNr', { fg = colors.fg_dark, bg = colors.bg })
hl('LineNrAbove', { fg = colors.fg_dark, bg = colors.bg })
hl('LineNrBelow', { fg = colors.fg_dark, bg = colors.bg })
hl('CursorLineNr', { fg = colors.blue, bg = colors.bg, bold = true })
hl('CursorLineFold', { fg = colors.fg_dark, bg = colors.cursor_line })
hl('CursorLineSign', { fg = colors.fg_dark, bg = colors.cursor_line })

-- Sign column and folds
hl('SignColumn', { fg = colors.fg_dark, bg = colors.bg })
hl('FoldColumn', { fg = colors.fg_dark, bg = colors.bg })
hl('Folded', { fg = colors.fg_alt, bg = colors.bg_alt, italic = true })

-- Borders and separators
hl('FloatBorder', { fg = colors.border, bg = colors.bg })
hl('FloatTitle', { fg = colors.blue, bg = colors.bg, bold = true })
hl('FloatFooter', { fg = colors.fg_alt, bg = colors.bg })
hl('WinSeparator', { fg = colors.border, bg = colors.bg })
hl('VertSplit', { fg = colors.border, bg = colors.bg }) -- Legacy support

-- Window and buffer elements
hl('Winsbar', { fg = colors.fg, bg = colors.bg })
hl('WinsbarNC', { fg = colors.fg_dark, bg = colors.bg })
hl('EndOfBuffer', { fg = colors.bg })
hl('NonText', { fg = colors.fg_dark })
hl('Whitespace', { fg = colors.fg_dark })
hl('SpecialKey', { fg = colors.fg_dark })
hl('Conceal', { fg = colors.fg_dark })

-- Directory and file types
hl('Directory', { fg = colors.blue, bold = true })
hl('Title', { fg = colors.blue, bold = true })

-- Diff highlights
hl('DiffAdd', { fg = colors.git_add, bg = colors.bg })
hl('DiffChange', { fg = colors.git_change, bg = colors.bg })
hl('DiffDelete', { fg = colors.git_delete, bg = colors.bg })
hl('DiffText', { fg = colors.bg, bg = colors.git_change })
hl('DiffAdded', { fg = colors.git_add })
hl('DiffRemoved', { fg = colors.git_delete })
hl('DiffFile', { fg = colors.blue })
hl('DiffNewFile', { fg = colors.green })
hl('DiffLine', { fg = colors.cyan })

-- Search highlights
hl('Search', { fg = colors.bg, bg = colors.yellow })
hl('IncSearch', { fg = colors.bg, bg = colors.orange })
hl('CurSearch', { fg = colors.bg, bg = colors.orange })
hl('Substitute', { fg = colors.bg, bg = colors.coral })

-- Messages and prompts
hl('ModeMsg', { fg = colors.green, bold = true })
hl('MoreMsg', { fg = colors.cyan })
hl('Question', { fg = colors.blue })
hl('ErrorMsg', { fg = colors.error, bold = true })
hl('WarningMsg', { fg = colors.warning, bold = true })
hl('MsgArea', { fg = colors.fg, bg = colors.bg })
hl('MsgSeparator', { fg = colors.border, bg = colors.bg })

-- Statusline and tabline
hl('StatusLine', { fg = colors.fg, bg = colors.bg_alt })
hl('StatusLineNC', { fg = colors.fg_dark, bg = colors.bg_alt })
hl('TabLine', { fg = colors.fg_alt, bg = colors.bg_alt })
hl('TabLineSel', { fg = colors.fg, bg = colors.bg, bold = true })
hl('TabLineFill', { bg = colors.bg_alt })

-- Popup and completion menus
hl('Pmenu', { fg = colors.fg, bg = colors.bg_alt })
hl('PmenuSel', { fg = colors.bg, bg = colors.blue })
hl('PmenuKind', { fg = colors.yellow, bg = colors.bg_alt })
hl('PmenuKindSel', { fg = colors.bg, bg = colors.blue })
hl('PmenuExtra', { fg = colors.fg_alt, bg = colors.bg_alt })
hl('PmenuExtraSel', { fg = colors.bg, bg = colors.blue })
hl('PmenuSbar', { bg = colors.bg_light })
hl('PmenuThumb', { bg = colors.border })
hl('PmenuMatch', { fg = colors.blue, bg = colors.bg_alt, bold = true })
hl('PmenuMatchSel', { fg = colors.bg, bg = colors.blue, bold = true })

-- Wild menu (command completion)
hl('WildMenu', { fg = colors.bg, bg = colors.blue })

-- QuickFix and Location lists
hl('QuickFixLine', { bg = colors.cursor_line })
hl('qfLineNr', { fg = colors.yellow })
hl('qfFileName', { fg = colors.blue })

-- ============================================================================
-- SYNTAX HIGHLIGHTING - Traditional vim syntax groups
-- ============================================================================

hl('Comment', { fg = colors.fg_dark, italic = true })

-- Constants
hl('Constant', { fg = colors.red })
hl('String', { fg = colors.green })
hl('Character', { fg = colors.green })
hl('Number', { fg = colors.red })
hl('Boolean', { fg = colors.red })
hl('Float', { fg = colors.red })

-- Identifiers
hl('Identifier', { fg = colors.cyan })
hl('Function', { fg = colors.blue })

-- Statements
hl('Statement', { fg = colors.coral })
hl('Conditional', { fg = colors.coral })
hl('Repeat', { fg = colors.coral })
hl('Label', { fg = colors.coral })
hl('Operator', { fg = colors.fg })
hl('Keyword', { fg = colors.coral })
hl('Exception', { fg = colors.coral })

-- PreProcessor
hl('PreProc', { fg = colors.magenta })
hl('Include', { fg = colors.coral })
hl('Define', { fg = colors.coral })
hl('Macro', { fg = colors.magenta })
hl('PreCondit', { fg = colors.magenta })

-- Types
hl('Type', { fg = colors.yellow })
hl('StorageClass', { fg = colors.yellow })
hl('Structure', { fg = colors.yellow })
hl('Typedef', { fg = colors.yellow })

-- Special
hl('Special', { fg = colors.orange })
hl('SpecialChar', { fg = colors.orange })
hl('Tag', { fg = colors.blue })
hl('Delimiter', { fg = colors.fg_alt })
hl('SpecialComment', { fg = colors.cyan, italic = true })
hl('Debug', { fg = colors.red })

-- Other
hl('Underlined', { fg = colors.blue, underline = true })
hl('Ignore', { fg = colors.fg_dark })
hl('Error', { fg = colors.error, bold = true })
hl('Todo', { fg = colors.yellow, bg = colors.bg, bold = true })

-- Matching brackets
hl('MatchParen', { fg = colors.match_paren, bold = true })

-- Spell checking
hl('SpellBad', { fg = colors.error, underline = true, sp = colors.error })
hl('SpellCap', { fg = colors.warning, underline = true, sp = colors.warning })
hl('SpellLocal', { fg = colors.info, underline = true, sp = colors.info })
hl('SpellRare', { fg = colors.hint, underline = true, sp = colors.hint })

-- ============================================================================
-- LSP AND DIAGNOSTICS
-- ============================================================================

-- LSP diagnostics
hl('DiagnosticError', { fg = colors.error })
hl('DiagnosticWarn', { fg = colors.warning })
hl('DiagnosticInfo', { fg = colors.info })
hl('DiagnosticHint', { fg = colors.hint })
hl('DiagnosticOk', { fg = colors.ok })

-- LSP diagnostic underlines
hl('DiagnosticUnderlineError', { underline = true, sp = colors.error })
hl('DiagnosticUnderlineWarn', { underline = true, sp = colors.warning })
hl('DiagnosticUnderlineInfo', { underline = true, sp = colors.info })
hl('DiagnosticUnderlineHint', { underline = true, sp = colors.hint })
hl('DiagnosticUnderlineOk', { underline = true, sp = colors.ok })

-- LSP diagnostic virtual text
hl('DiagnosticVirtualTextError', { fg = colors.error, bg = colors.bg, italic = true })
hl('DiagnosticVirtualTextWarn', { fg = colors.warning, bg = colors.bg, italic = true })
hl('DiagnosticVirtualTextInfo', { fg = colors.info, bg = colors.bg, italic = true })
hl('DiagnosticVirtualTextHint', { fg = colors.hint, bg = colors.bg, italic = true })
hl('DiagnosticVirtualTextOk', { fg = colors.ok, bg = colors.bg, italic = true })

-- LSP diagnostic signs (in sign column)
hl('DiagnosticSignError', { fg = colors.error, bg = colors.bg })
hl('DiagnosticSignWarn', { fg = colors.warning, bg = colors.bg })
hl('DiagnosticSignInfo', { fg = colors.info, bg = colors.bg })
hl('DiagnosticSignHint', { fg = colors.hint, bg = colors.bg })
hl('DiagnosticSignOk', { fg = colors.ok, bg = colors.bg })

-- LSP floating diagnostic window
hl('DiagnosticFloatingError', { fg = colors.error, bg = colors.bg })
hl('DiagnosticFloatingWarn', { fg = colors.warning, bg = colors.bg })
hl('DiagnosticFloatingInfo', { fg = colors.info, bg = colors.bg })
hl('DiagnosticFloatingHint', { fg = colors.hint, bg = colors.bg })
hl('DiagnosticFloatingOk', { fg = colors.ok, bg = colors.bg })

-- LSP references and document highlights
hl('LspReferenceText', { bg = colors.bg_light })
hl('LspReferenceRead', { bg = colors.bg_light })
hl('LspReferenceWrite', { bg = colors.bg_light, bold = true })
hl('LspCodeLens', { fg = colors.fg_dark, italic = true })
hl('LspCodeLensSeparator', { fg = colors.fg_dark })
hl('LspSignatureActiveParameter', { fg = colors.orange, bold = true })
hl('LspInfoBorder', { fg = colors.border, bg = colors.bg })

-- ============================================================================
-- TREESITTER SEMANTIC HIGHLIGHTING - Modern syntax highlighting
-- ============================================================================

-- Variables
hl('@variable', { fg = colors.fg })
hl('@variable.builtin', { fg = colors.red })
hl('@variable.parameter', { fg = colors.fg_alt })
hl('@variable.member', { fg = colors.cyan })

-- Constants
hl('@constant', { fg = colors.red })
hl('@constant.builtin', { fg = colors.red })
hl('@constant.macro', { fg = colors.yellow })

-- Strings and characters
hl('@string', { fg = colors.green })
hl('@string.documentation', { fg = colors.green, italic = true })
hl('@string.regex', { fg = colors.orange })
hl('@string.escape', { fg = colors.orange })
hl('@string.special', { fg = colors.orange })
hl('@string.special.symbol', { fg = colors.orange })
hl('@string.special.url', { fg = colors.cyan, underline = true })
hl('@character', { fg = colors.green })
hl('@character.special', { fg = colors.orange })

-- Numbers
hl('@number', { fg = colors.red })
hl('@number.float', { fg = colors.red })

-- Booleans
hl('@boolean', { fg = colors.red })

-- Functions
hl('@function', { fg = colors.blue })
hl('@function.builtin', { fg = colors.blue })
hl('@function.call', { fg = colors.blue })
hl('@function.macro', { fg = colors.magenta })
hl('@function.method', { fg = colors.blue })
hl('@function.method.call', { fg = colors.blue })
hl('@method', { fg = colors.blue })
hl('@method.call', { fg = colors.blue })
hl('@constructor', { fg = colors.yellow })

-- Keywords
hl('@keyword', { fg = colors.coral })
hl('@keyword.conditional', { fg = colors.coral })
hl('@keyword.repeat', { fg = colors.coral })
hl('@keyword.return', { fg = colors.coral })
hl('@keyword.debug', { fg = colors.coral })
hl('@keyword.exception', { fg = colors.coral })
hl('@keyword.import', { fg = colors.coral })
hl('@keyword.export', { fg = colors.coral })
hl('@keyword.storage', { fg = colors.coral })
hl('@keyword.function', { fg = colors.coral })
hl('@keyword.operator', { fg = colors.coral })
hl('@keyword.directive', { fg = colors.magenta })
hl('@keyword.directive.define', { fg = colors.magenta })

-- Operators
hl('@operator', { fg = colors.fg })

-- Punctuation
hl('@punctuation.delimiter', { fg = colors.fg_alt })
hl('@punctuation.bracket', { fg = colors.fg })
hl('@punctuation.special', { fg = colors.orange })

-- Types
hl('@type', { fg = colors.yellow })
hl('@type.builtin', { fg = colors.yellow })
hl('@type.definition', { fg = colors.yellow })
hl('@type.qualifier', { fg = colors.coral })

-- Attributes and annotations
hl('@attribute', { fg = colors.magenta })
hl('@attribute.builtin', { fg = colors.magenta })

-- Properties and fields
hl('@property', { fg = colors.cyan })
hl('@field', { fg = colors.cyan })

-- Labels
hl('@label', { fg = colors.coral })

-- Namespaces and modules
hl('@namespace', { fg = colors.cyan })
hl('@module', { fg = colors.cyan })
hl('@module.builtin', { fg = colors.cyan })

-- Comments
hl('@comment', { fg = colors.fg_dark, italic = true })
hl('@comment.documentation', { fg = colors.fg_dark, italic = true })
hl('@comment.error', { fg = colors.error, italic = true })
hl('@comment.warning', { fg = colors.warning, italic = true })
hl('@comment.todo', { fg = colors.yellow, bold = true })
hl('@comment.note', { fg = colors.info, italic = true })

-- Tags (HTML, XML)
hl('@tag', { fg = colors.blue })
hl('@tag.builtin', { fg = colors.blue })
hl('@tag.attribute', { fg = colors.cyan })
hl('@tag.delimiter', { fg = colors.fg_alt })

-- Markup (Markdown, etc.)
hl('@markup', { fg = colors.fg })
hl('@markup.strong', { fg = colors.fg, bold = true })
hl('@markup.italic', { fg = colors.fg, italic = true })
hl('@markup.strikethrough', { fg = colors.fg, strikethrough = true })
hl('@markup.underline', { fg = colors.fg, underline = true })
hl('@markup.heading', { fg = colors.blue, bold = true })
hl('@markup.heading.1', { fg = colors.blue, bold = true })
hl('@markup.heading.2', { fg = colors.coral, bold = true })
hl('@markup.heading.3', { fg = colors.green, bold = true })
hl('@markup.heading.4', { fg = colors.yellow, bold = true })
hl('@markup.heading.5', { fg = colors.cyan, bold = true })
hl('@markup.heading.6', { fg = colors.magenta, bold = true })
hl('@markup.quote', { fg = colors.fg_alt, italic = true })
hl('@markup.math', { fg = colors.orange })
hl('@markup.link', { fg = colors.blue, underline = true })
hl('@markup.link.label', { fg = colors.blue })
hl('@markup.link.url', { fg = colors.cyan, underline = true })
hl('@markup.raw', { fg = colors.green })
hl('@markup.raw.inline', { fg = colors.green })
hl('@markup.raw.block', { fg = colors.green })
hl('@markup.list', { fg = colors.coral })
hl('@markup.list.checked', { fg = colors.green })
hl('@markup.list.unchecked', { fg = colors.fg_alt })

-- Diff
hl('@diff.plus', { fg = colors.git_add })
hl('@diff.minus', { fg = colors.git_delete })
hl('@diff.delta', { fg = colors.git_change })

-- ============================================================================
-- LANGUAGE-SPECIFIC HIGHLIGHTS
-- ============================================================================

-- Bash/Shell
hl('@keyword.bash', { fg = colors.coral })
hl('@function.bash', { fg = colors.blue })
hl('@variable.bash', { fg = colors.cyan })
hl('@string.bash', { fg = colors.green })
hl('@punctuation.special.bash', { fg = colors.orange })
hl('@operator.bash', { fg = colors.fg })

-- C/C++
hl('@keyword.c', { fg = colors.coral })
hl('@keyword.cpp', { fg = colors.coral })
hl('@type.c', { fg = colors.yellow })
hl('@type.cpp', { fg = colors.yellow })
hl('@type.builtin.c', { fg = colors.yellow })
hl('@type.builtin.cpp', { fg = colors.yellow })
hl('@function.c', { fg = colors.blue })
hl('@function.cpp', { fg = colors.blue })
hl('@variable.c', { fg = colors.cyan })
hl('@variable.cpp', { fg = colors.cyan })
hl('@namespace.cpp', { fg = colors.cyan })
hl('@preproc.c', { fg = colors.magenta })
hl('@preproc.cpp', { fg = colors.magenta })

-- C#
hl('@keyword.cs', { fg = colors.coral })
hl('@type.cs', { fg = colors.yellow })
hl('@type.builtin.cs', { fg = colors.yellow })
hl('@function.cs', { fg = colors.blue })
hl('@variable.cs', { fg = colors.cyan })
hl('@attribute.cs', { fg = colors.magenta })

-- CSS
hl('@property.css', { fg = colors.blue })
hl('@string.css', { fg = colors.green })
hl('@number.css', { fg = colors.red })
hl('@type.css', { fg = colors.coral })
hl('@function.css', { fg = colors.yellow })
hl('@keyword.css', { fg = colors.coral })

-- Dart
hl('@keyword.dart', { fg = colors.coral })
hl('@type.dart', { fg = colors.yellow })
hl('@type.builtin.dart', { fg = colors.yellow })
hl('@function.dart', { fg = colors.blue })
hl('@variable.dart', { fg = colors.cyan })
hl('@annotation.dart', { fg = colors.magenta })

-- Docker
hl('@keyword.dockerfile', { fg = colors.coral })
hl('@string.dockerfile', { fg = colors.green })
hl('@variable.dockerfile', { fg = colors.cyan })

-- Elixir
hl('@keyword.elixir', { fg = colors.coral })
hl('@function.elixir', { fg = colors.blue })
hl('@variable.elixir', { fg = colors.cyan })
hl('@string.elixir', { fg = colors.green })
hl('@symbol.elixir', { fg = colors.orange })
hl('@module.elixir', { fg = colors.yellow })

-- Erlang
hl('@keyword.erlang', { fg = colors.coral })
hl('@function.erlang', { fg = colors.blue })
hl('@variable.erlang', { fg = colors.cyan })
hl('@string.erlang', { fg = colors.green })
hl('@atom.erlang', { fg = colors.orange })

-- Go
hl('@keyword.go', { fg = colors.coral })
hl('@type.go', { fg = colors.yellow })
hl('@type.builtin.go', { fg = colors.yellow })
hl('@function.go', { fg = colors.blue })
hl('@variable.go', { fg = 'NONE' })
hl('@constant.go', { fg = colors.red })

-- Haskell
hl('@keyword.haskell', { fg = colors.coral })
hl('@type.haskell', { fg = colors.yellow })
hl('@function.haskell', { fg = colors.blue })
hl('@variable.haskell', { fg = colors.cyan })
hl('@constructor.haskell', { fg = colors.yellow })
hl('@operator.haskell', { fg = colors.fg })

-- HTML
hl('@tag.html', { fg = colors.coral })
hl('@tag.attribute.html', { fg = colors.blue })
hl('@string.html', { fg = colors.green })

-- Java
hl('@keyword.java', { fg = colors.coral })
hl('@type.java', { fg = colors.yellow })
hl('@type.builtin.java', { fg = colors.yellow })
hl('@function.java', { fg = colors.blue })
hl('@variable.java', { fg = colors.cyan })
hl('@annotation.java', { fg = colors.magenta })

-- JavaScript/TypeScript
hl('@keyword.javascript', { fg = colors.coral })
hl('@keyword.typescript', { fg = colors.coral })
hl('@constructor.javascript', { fg = colors.yellow })
hl('@constructor.typescript', { fg = colors.yellow })
hl('@variable.member.javascript', { fg = colors.cyan })
hl('@variable.member.typescript', { fg = colors.cyan })
hl('@keyword.import.javascript', { fg = colors.coral })
hl('@keyword.import.typescript', { fg = colors.coral })
hl('@keyword.export.javascript', { fg = colors.coral })
hl('@keyword.export.typescript', { fg = colors.coral })
hl('@function.javascript', { fg = colors.blue })
hl('@function.typescript', { fg = colors.blue })

-- JSON
hl('@field.json', { fg = colors.blue })
hl('@property.json', { fg = colors.blue })
hl('@string.json', { fg = colors.green })
hl('@number.json', { fg = colors.red })
hl('@boolean.json', { fg = colors.red })
hl('@constant.builtin.json', { fg = colors.red })
hl('@punctuation.bracket.json', { fg = colors.fg })
hl('@punctuation.delimiter.json', { fg = colors.fg_alt })

-- Julia
hl('@keyword.julia', { fg = colors.coral })
hl('@function.julia', { fg = colors.blue })
hl('@variable.julia', { fg = colors.cyan })
hl('@type.julia', { fg = colors.yellow })
hl('@macro.julia', { fg = colors.magenta })

-- Kotlin
hl('@keyword.kotlin', { fg = colors.coral })
hl('@type.kotlin', { fg = colors.yellow })
hl('@type.builtin.kotlin', { fg = colors.yellow })
hl('@function.kotlin', { fg = colors.blue })
hl('@variable.kotlin', { fg = colors.cyan })
hl('@annotation.kotlin', { fg = colors.magenta })

-- Lua
hl('@keyword.lua', { fg = colors.coral })
hl('@function.lua', { fg = colors.blue })
hl('@variable.lua', { fg = colors.cyan })
hl('@constant.lua', { fg = colors.red })
hl('@string.lua', { fg = colors.green })
hl('@function.builtin.lua', { fg = colors.blue })
hl('@constant.builtin.lua', { fg = colors.red })

-- Markdown
hl('@markup.heading.1.markdown', { fg = colors.blue, bold = true })
hl('@markup.heading.2.markdown', { fg = colors.coral, bold = true })
hl('@markup.heading.3.markdown', { fg = colors.green, bold = true })
hl('@markup.heading.4.markdown', { fg = colors.yellow, bold = true })
hl('@markup.heading.5.markdown', { fg = colors.cyan, bold = true })
hl('@markup.heading.6.markdown', { fg = colors.magenta, bold = true })
hl('@markup.list.markdown', { fg = colors.coral })
hl('@markup.link.markdown', { fg = colors.blue, underline = true })
hl('@markup.raw.markdown', { fg = colors.green })
hl('@markup.raw.inline.markdown', { fg = colors.green })
hl('@markup.quote.markdown', { fg = colors.fg_alt, italic = true })
hl('@markup.strong.markdown', { fg = colors.fg, bold = true })
hl('@markup.italic.markdown', { fg = colors.fg, italic = true })

-- Nix
hl('@keyword.nix', { fg = colors.coral })
hl('@function.nix', { fg = colors.blue })
hl('@variable.nix', { fg = colors.cyan })
hl('@string.nix', { fg = colors.green })
hl('@attribute.nix', { fg = colors.yellow })

-- OCaml
hl('@keyword.ocaml', { fg = colors.coral })
hl('@function.ocaml', { fg = colors.blue })
hl('@variable.ocaml', { fg = colors.cyan })
hl('@type.ocaml', { fg = colors.yellow })
hl('@constructor.ocaml', { fg = colors.yellow })
hl('@module.ocaml', { fg = colors.cyan })

-- PHP
hl('@keyword.php', { fg = colors.coral })
hl('@type.php', { fg = colors.yellow })
hl('@function.php', { fg = colors.blue })
hl('@variable.php', { fg = colors.cyan })
hl('@constant.php', { fg = colors.red })
hl('@string.php', { fg = colors.green })
hl('@variable.builtin.php', { fg = colors.red })

-- Python
hl('@keyword.python', { fg = colors.coral })
hl('@keyword.import.python', { fg = colors.coral })
hl('@constructor.python', { fg = colors.yellow })
hl('@variable.member.python', { fg = colors.cyan })
hl('@function.builtin.python', { fg = colors.blue })
hl('@constant.builtin.python', { fg = colors.red })
hl('@function.python', { fg = colors.blue })
hl('@variable.python', { fg = colors.cyan })
hl('@decorator.python', { fg = colors.magenta })

-- R
hl('@keyword.r', { fg = colors.coral })
hl('@function.r', { fg = colors.blue })
hl('@variable.r', { fg = colors.cyan })
hl('@string.r', { fg = colors.green })
hl('@operator.r', { fg = colors.fg })

-- Ruby
hl('@keyword.ruby', { fg = colors.coral })
hl('@keyword.import.ruby', { fg = colors.coral })
hl('@type.ruby', { fg = colors.yellow })
hl('@function.ruby', { fg = colors.blue })
hl('@variable.ruby', { fg = colors.cyan })
hl('@constant.ruby', { fg = colors.red })
hl('@string.ruby', { fg = colors.green })
hl('@symbol.ruby', { fg = colors.orange })
hl('@variable.builtin.ruby', { fg = colors.red })

-- Rust
hl('@keyword.rust', { fg = colors.coral })
hl('@keyword.import.rust', { fg = colors.coral })
hl('@type.rust', { fg = colors.yellow })
hl('@type.builtin.rust', { fg = colors.yellow })
hl('@function.rust', { fg = colors.blue })
hl('@variable.rust', { fg = colors.cyan })
hl('@constant.rust', { fg = colors.red })
hl('@string.rust', { fg = colors.green })
hl('@attribute.rust', { fg = colors.magenta })
hl('@macro.rust', { fg = colors.magenta })

-- Scala
hl('@keyword.scala', { fg = colors.coral })
hl('@type.scala', { fg = colors.yellow })
hl('@function.scala', { fg = colors.blue })
hl('@variable.scala', { fg = colors.cyan })
hl('@annotation.scala', { fg = colors.magenta })

-- SQL
hl('@keyword.sql', { fg = colors.coral })
hl('@type.sql', { fg = colors.yellow })
hl('@function.sql', { fg = colors.blue })
hl('@string.sql', { fg = colors.green })
hl('@number.sql', { fg = colors.red })
hl('@operator.sql', { fg = colors.fg })

-- Swift
hl('@keyword.swift', { fg = colors.coral })
hl('@keyword.import.swift', { fg = colors.coral })
hl('@type.swift', { fg = colors.yellow })
hl('@type.builtin.swift', { fg = colors.yellow })
hl('@function.swift', { fg = colors.blue })
hl('@variable.swift', { fg = colors.cyan })
hl('@constant.swift', { fg = colors.red })
hl('@string.swift', { fg = colors.green })
hl('@attribute.swift', { fg = colors.magenta })

-- TOML
hl('@field.toml', { fg = colors.blue })
hl('@property.toml', { fg = colors.blue })
hl('@string.toml', { fg = colors.green })
hl('@number.toml', { fg = colors.red })
hl('@boolean.toml', { fg = colors.red })
hl('@constant.builtin.toml', { fg = colors.red })
hl('@type.toml', { fg = colors.yellow })

-- Vim script
hl('@keyword.vim', { fg = colors.coral })
hl('@function.vim', { fg = colors.blue })
hl('@variable.vim', { fg = colors.cyan })
hl('@constant.vim', { fg = colors.red })
hl('@string.vim', { fg = colors.green })
hl('@function.builtin.vim', { fg = colors.blue })

-- XML
hl('@tag.xml', { fg = colors.coral })
hl('@tag.attribute.xml', { fg = colors.blue })
hl('@string.xml', { fg = colors.green })

-- YAML
hl('@field.yaml', { fg = colors.blue })
hl('@property.yaml', { fg = colors.blue })
hl('@string.yaml', { fg = colors.green })
hl('@number.yaml', { fg = colors.red })
hl('@boolean.yaml', { fg = colors.red })
hl('@constant.builtin.yaml', { fg = colors.red })
hl('@punctuation.delimiter.yaml', { fg = colors.fg_alt })
hl('@punctuation.special.yaml', { fg = colors.coral })
hl('@operator.yaml', { fg = colors.coral })
hl('@type.yaml', { fg = colors.yellow })
hl('@tag.yaml', { fg = colors.magenta })
hl('@label.yaml', { fg = colors.cyan })

-- Zig
hl('@keyword.zig', { fg = colors.coral })
hl('@function.zig', { fg = colors.blue })
hl('@variable.zig', { fg = colors.cyan })
hl('@type.zig', { fg = colors.yellow })
hl('@type.builtin.zig', { fg = colors.yellow })

-- Additional languages
-- Assembly
hl('@keyword.asm', { fg = colors.coral })
hl('@function.asm', { fg = colors.blue })
hl('@label.asm', { fg = colors.cyan })
hl('@register.asm', { fg = colors.red })

-- FORTRAN
hl('@keyword.fortran', { fg = colors.coral })
hl('@function.fortran', { fg = colors.blue })
hl('@variable.fortran', { fg = colors.cyan })
hl('@type.fortran', { fg = colors.yellow })

-- COBOL
hl('@keyword.cobol', { fg = colors.coral })
hl('@function.cobol', { fg = colors.blue })
hl('@variable.cobol', { fg = colors.cyan })

-- Pascal
hl('@keyword.pascal', { fg = colors.coral })
hl('@function.pascal', { fg = colors.blue })
hl('@variable.pascal', { fg = colors.cyan })
hl('@type.pascal', { fg = colors.yellow })

-- Ada
hl('@keyword.ada', { fg = colors.coral })
hl('@function.ada', { fg = colors.blue })
hl('@variable.ada', { fg = colors.cyan })
hl('@type.ada', { fg = colors.yellow })

-- Perl
hl('@keyword.perl', { fg = colors.coral })
hl('@function.perl', { fg = colors.blue })
hl('@variable.perl', { fg = colors.cyan })
hl('@string.perl', { fg = colors.green })

-- Tcl
hl('@keyword.tcl', { fg = colors.coral })
hl('@function.tcl', { fg = colors.blue })
hl('@variable.tcl', { fg = colors.cyan })
hl('@string.tcl', { fg = colors.green })

-- ============================================================================
-- RPM SPEC FILE SUPPORT (Enhanced)
-- ============================================================================

-- TreeSitter highlights for spec files
hl('@keyword.spec', { fg = colors.coral })
hl('@function.spec', { fg = colors.blue })
hl('@variable.spec', { fg = colors.cyan })
hl('@constant.spec', { fg = colors.red })
hl('@string.spec', { fg = colors.green })
hl('@comment.spec', { fg = colors.fg_dark, italic = true })
hl('@type.spec', { fg = colors.yellow })
hl('@operator.spec', { fg = colors.fg })
hl('@punctuation.spec', { fg = colors.fg_alt })
hl('@punctuation.delimiter.spec', { fg = colors.fg_alt })
hl('@tag.spec', { fg = colors.orange })
hl('@attribute.spec', { fg = colors.magenta })
hl('@number.spec', { fg = colors.red })

-- Traditional vim syntax for spec files
hl('specSection', { fg = colors.coral, bold = true })
hl('specSectionMacro', { fg = colors.coral, bold = true })
hl('specMacro', { fg = colors.blue })
hl('specVariables', { fg = colors.cyan })
hl('specGlobalMacro', { fg = colors.blue })
hl('specCommandOpts', { fg = colors.magenta })
hl('specComment', { fg = colors.fg_dark, italic = true })
hl('specConfigure', { fg = colors.yellow })
hl('specTarCommand', { fg = colors.yellow })
hl('specMake', { fg = colors.yellow })
hl('specInstall', { fg = colors.yellow })
hl('specRpmMacro', { fg = colors.blue })
hl('specSpecialChar', { fg = colors.orange })
hl('specSpecialVariables', { fg = colors.cyan })
hl('specSpecialVariablesNames', { fg = colors.cyan })
hl('specListedFiles', { fg = colors.green })
hl('specListedFilesPrefix', { fg = colors.magenta })
hl('specFilesDir', { fg = colors.green })
hl('specAttr', { fg = colors.orange })
hl('specDefine', { fg = colors.coral })
hl('specDefineName', { fg = colors.blue })
hl('specDefineValue', { fg = colors.green })
hl('specGlobal', { fg = colors.coral })
hl('specGlobalName', { fg = colors.blue })
hl('specGlobalValue', { fg = colors.green })
hl('specPackage', { fg = colors.yellow })
hl('specPackageName', { fg = colors.yellow })
hl('specDescription', { fg = colors.green })
hl('specDescriptionOpts', { fg = colors.magenta })
hl('specChangelog', { fg = colors.fg_alt })
hl('specChangelogHeader', { fg = colors.blue })
hl('specLicense', { fg = colors.green })
hl('specURL', { fg = colors.cyan, underline = true })
hl('specEmail', { fg = colors.cyan })
hl('specUnknown', { fg = colors.error })
hl('specTag', { fg = colors.orange, bold = true })
hl('specTagName', { fg = colors.orange, bold = true })
hl('specTagValue', { fg = colors.green })
hl('specName', { fg = colors.yellow })
hl('specVersion', { fg = colors.red })
hl('specRelease', { fg = colors.red })
hl('specEpoch', { fg = colors.red })
hl('specSummary', { fg = colors.green })
hl('specGroup', { fg = colors.yellow })
hl('specSource', { fg = colors.cyan })
hl('specPatch', { fg = colors.magenta })
hl('specBuildArch', { fg = colors.yellow })
hl('specExclusiveArch', { fg = colors.yellow })
hl('specBuildRequires', { fg = colors.cyan })
hl('specRequires', { fg = colors.cyan })
hl('specProvides', { fg = colors.cyan })
hl('specObsoletes', { fg = colors.red })
hl('specConflicts', { fg = colors.red })

-- ============================================================================
-- PLUGIN-SPECIFIC HIGHLIGHTS
-- ============================================================================

-- Git signs (for gitsigns.nvim)
hl('GitSignsAdd', { fg = colors.git_add, bg = colors.bg })
hl('GitSignsChange', { fg = colors.git_change, bg = colors.bg })
hl('GitSignsDelete', { fg = colors.git_delete, bg = colors.bg })
hl('GitSignsAddNr', { fg = colors.git_add, bg = colors.bg })
hl('GitSignsChangeNr', { fg = colors.git_change, bg = colors.bg })
hl('GitSignsDeleteNr', { fg = colors.git_delete, bg = colors.bg })
hl('GitSignsAddLn', { bg = '#2d4a2e' })
hl('GitSignsChangeLn', { bg = '#4a4527' })
hl('GitSignsDeleteLn', { bg = '#4a2d2d' })
hl('GitSignsCurrentLineBlame', { fg = colors.fg_dark, italic = true })

-- Telescope
hl('TelescopeBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopeNormal', { fg = colors.fg, bg = colors.bg })
hl('TelescopeSelection', { bg = colors.cursor_line })
hl('TelescopeSelectionCaret', { fg = colors.blue, bg = colors.cursor_line })
hl('TelescopeMatching', { fg = colors.orange, bold = true })
hl('TelescopePromptBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopePromptNormal', { fg = colors.fg, bg = colors.bg })
hl('TelescopePromptPrefix', { fg = colors.blue })
hl('TelescopePromptCounter', { fg = colors.fg_alt })
hl('TelescopePromptTitle', { fg = colors.blue, bold = true })
hl('TelescopeResultsBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopeResultsNormal', { fg = colors.fg, bg = colors.bg })
hl('TelescopeResultsTitle', { fg = colors.green, bold = true })
hl('TelescopePreviewBorder', { fg = colors.border, bg = colors.bg })
hl('TelescopePreviewNormal', { fg = colors.fg, bg = colors.bg })
hl('TelescopePreviewTitle', { fg = colors.coral, bold = true })

-- Tree-sitter context
hl('TreesitterContext', { bg = colors.bg_alt })
hl('TreesitterContextLineNumber', { fg = colors.fg_dark, bg = colors.bg_alt })
hl('TreesitterContextBottom', { underline = true, sp = colors.border })

-- Which-key
hl('WhichKey', { fg = colors.blue })
hl('WhichKeyGroup', { fg = colors.coral })
hl('WhichKeyDesc', { fg = colors.fg })
hl('WhichKeySeperator', { fg = colors.fg_dark })
hl('WhichKeyFloat', { bg = colors.bg })
hl('WhichKeyBorder', { fg = colors.border, bg = colors.bg })
hl('WhichKeyValue', { fg = colors.green })

-- Notify
hl('NotifyBackground', { bg = colors.bg })
hl('NotifyERRORBorder', { fg = colors.error, bg = colors.bg })
hl('NotifyERRORIcon', { fg = colors.error })
hl('NotifyERRORTitle', { fg = colors.error, bold = true })
hl('NotifyWARNBorder', { fg = colors.warning, bg = colors.bg })
hl('NotifyWARNIcon', { fg = colors.warning })
hl('NotifyWARNTitle', { fg = colors.warning, bold = true })
hl('NotifyINFOBorder', { fg = colors.info, bg = colors.bg })
hl('NotifyINFOIcon', { fg = colors.info })
hl('NotifyINFOTitle', { fg = colors.info, bold = true })
hl('NotifyDEBUGBorder', { fg = colors.hint, bg = colors.bg })
hl('NotifyDEBUGIcon', { fg = colors.hint })
hl('NotifyDEBUGTitle', { fg = colors.hint, bold = true })
hl('NotifyTRACEBorder', { fg = colors.fg_alt, bg = colors.bg })
hl('NotifyTRACEIcon', { fg = colors.fg_alt })
hl('NotifyTRACETitle', { fg = colors.fg_alt, bold = true })

-- Mason (LSP installer)
hl('MasonNormal', { fg = colors.fg, bg = colors.bg })
hl('MasonHeader', { fg = colors.bg, bg = colors.blue, bold = true })
hl('MasonHeaderSecondary', { fg = colors.bg, bg = colors.coral, bold = true })
hl('MasonHighlight', { fg = colors.blue })
hl('MasonHighlightBlock', { fg = colors.bg, bg = colors.blue })
hl('MasonHighlightBlockBold', { fg = colors.bg, bg = colors.blue, bold = true })
hl('MasonHighlightSecondary', { fg = colors.coral })
hl('MasonHighlightBlockSecondary', { fg = colors.bg, bg = colors.coral })
hl('MasonHighlightBlockBoldSecondary', { fg = colors.bg, bg = colors.coral, bold = true })
hl('MasonMuted', { fg = colors.fg_dark })
hl('MasonMutedBlock', { fg = colors.fg_alt, bg = colors.bg_light })
hl('MasonMutedBlockBold', { fg = colors.fg_alt, bg = colors.bg_light, bold = true })
hl('MasonError', { fg = colors.error })
hl('MasonWarning', { fg = colors.warning })

-- Lazy (plugin manager)
hl('LazyNormal', { fg = colors.fg, bg = colors.bg })
hl('LazyButton', { fg = colors.fg_alt, bg = colors.bg_light })
hl('LazyButtonActive', { fg = colors.bg, bg = colors.blue, bold = true })
hl('LazyComment', { fg = colors.fg_dark, italic = true })
hl('LazyCommit', { fg = colors.green })
hl('LazyCommitIssue', { fg = colors.coral })
hl('LazyCommitScope', { fg = colors.cyan, italic = true })
hl('LazyCommitType', { fg = colors.yellow })
hl('LazyDimmed', { fg = colors.fg_dark })
hl('LazyDir', { fg = colors.blue })
hl('LazyH1', { fg = colors.bg, bg = colors.blue, bold = true })
hl('LazyH2', { fg = colors.blue, bold = true })
hl('LazyLocal', { fg = colors.orange })
hl('LazyProgressDone', { fg = colors.green, bold = true })
hl('LazyProgressTodo', { fg = colors.fg_dark, bold = true })
hl('LazyProp', { fg = colors.coral })
hl('LazyReasonCmd', { fg = colors.cyan })
hl('LazyReasonEvent', { fg = colors.orange })
hl('LazyReasonFt', { fg = colors.yellow })
hl('LazyReasonImport', { fg = colors.magenta })
hl('LazyReasonKeys', { fg = colors.green })
hl('LazyReasonPlugin', { fg = colors.coral })
hl('LazyReasonRuntime', { fg = colors.yellow })
hl('LazyReasonSource', { fg = colors.cyan })
hl('LazyReasonStart', { fg = colors.blue })
hl('LazySpecial', { fg = colors.coral })
hl('LazyTaskError', { fg = colors.error })
hl('LazyTaskOutput', { fg = colors.fg })
hl('LazyUrl', { fg = colors.cyan, underline = true })
hl('LazyValue', { fg = colors.green })

-- nvim-cmp (completion)
hl('CmpItemMenu', { fg = colors.fg_alt, bg = colors.bg })
hl('CmpItemAbbrDeprecated', { fg = colors.fg_dark, bg = colors.bg, strikethrough = true })
hl('CmpItemAbbrMatch', { fg = colors.blue, bg = colors.bg, bold = true })
hl('CmpItemAbbrMatchFuzzy', { fg = colors.blue, bg = colors.bg, bold = true })
hl('CmpItemKind', { fg = colors.coral, bg = colors.bg })
hl('CmpItemKindClass', { fg = colors.yellow, bg = colors.bg })
hl('CmpItemKindConstant', { fg = colors.red, bg = colors.bg })
hl('CmpItemKindConstructor', { fg = colors.yellow, bg = colors.bg })
hl('CmpItemKindEnum', { fg = colors.yellow, bg = colors.bg })
hl('CmpItemKindEnumMember', { fg = colors.cyan, bg = colors.bg })
hl('CmpItemKindEvent', { fg = colors.orange, bg = colors.bg })
hl('CmpItemKindField', { fg = colors.cyan, bg = colors.bg })
hl('CmpItemKindFile', { fg = colors.blue, bg = colors.bg })
hl('CmpItemKindFolder', { fg = colors.blue, bg = colors.bg })
hl('CmpItemKindFunction', { fg = colors.blue, bg = colors.bg })
hl('CmpItemKindInterface', { fg = colors.yellow, bg = colors.bg })
hl('CmpItemKindKeyword', { fg = colors.coral, bg = colors.bg })
hl('CmpItemKindMethod', { fg = colors.blue, bg = colors.bg })
hl('CmpItemKindModule', { fg = colors.cyan, bg = colors.bg })
hl('CmpItemKindOperator', { fg = colors.fg, bg = colors.bg })
hl('CmpItemKindProperty', { fg = colors.cyan, bg = colors.bg })
hl('CmpItemKindReference', { fg = colors.orange, bg = colors.bg })
hl('CmpItemKindSnippet', { fg = colors.green, bg = colors.bg })
hl('CmpItemKindStruct', { fg = colors.yellow, bg = colors.bg })
hl('CmpItemKindText', { fg = colors.fg, bg = colors.bg })
hl('CmpItemKindTypeParameter', { fg = colors.yellow, bg = colors.bg })
hl('CmpItemKindUnit', { fg = colors.yellow, bg = colors.bg })
hl('CmpItemKindValue', { fg = colors.red, bg = colors.bg })
hl('CmpItemKindVariable', { fg = colors.cyan, bg = colors.bg })

-- LuaLine
hl('lualine_a_normal', { fg = colors.bg, bg = colors.blue, bold = true })
hl('lualine_a_insert', { fg = colors.bg, bg = colors.green, bold = true })
hl('lualine_a_visual', { fg = colors.bg, bg = colors.orange, bold = true })
hl('lualine_a_replace', { fg = colors.bg, bg = colors.red, bold = true })
hl('lualine_a_command', { fg = colors.bg, bg = colors.coral, bold = true })
hl('lualine_a_terminal', { fg = colors.bg, bg = colors.cyan, bold = true })
hl('lualine_b_normal', { fg = colors.fg, bg = colors.bg_alt })
hl('lualine_c_normal', { fg = colors.fg_alt, bg = colors.bg })

-- File explorer support (Oil.nvim)
hl('OilDir', { fg = colors.blue, bold = true })
hl('OilDirIcon', { fg = colors.blue })
hl('OilLink', { fg = colors.cyan })
hl('OilLinkTarget', { fg = colors.fg_alt })
hl('OilCopy', { fg = colors.yellow })
hl('OilMove', { fg = colors.orange })
hl('OilChange', { fg = colors.coral })
hl('OilCreate', { fg = colors.green })
hl('OilDelete', { fg = colors.red })
hl('OilPermissionRead', { fg = colors.green })
hl('OilPermissionWrite', { fg = colors.yellow })
hl('OilPermissionExecute', { fg = colors.red })
hl('OilTypeDir', { fg = colors.blue, bold = true })
hl('OilTypeFile', { fg = colors.fg })
hl('OilTypeLink', { fg = colors.cyan })
hl('OilTypeSocket', { fg = colors.magenta })
hl('OilTypeFifo', { fg = colors.orange })
hl('OilSize', { fg = colors.fg_alt })
hl('OilMtime', { fg = colors.fg_dark })
hl('OilRestore', { fg = colors.cyan })
hl('OilTrash', { fg = colors.red })
hl('OilTrashSourcePath', { fg = colors.fg_alt })

-- Neo-tree
hl('NeoTreeDirectoryIcon', { fg = colors.blue })
hl('NeoTreeDirectoryName', { fg = colors.blue, bold = true })
hl('NeoTreeFileName', { fg = colors.fg })
hl('NeoTreeFileIcon', { fg = colors.fg_alt })
hl('NeoTreeModified', { fg = colors.orange })
hl('NeoTreeGitAdded', { fg = colors.green })
hl('NeoTreeGitDeleted', { fg = colors.red })
hl('NeoTreeGitModified', { fg = colors.yellow })
hl('NeoTreeGitConflict', { fg = colors.coral })
hl('NeoTreeGitUntracked', { fg = colors.fg_dark })
hl('NeoTreeSymbolicLinkTarget', { fg = colors.cyan })
hl('NeoTreeRootName', { fg = colors.blue, bold = true })
hl('NeoTreeIndentMarker', { fg = colors.fg_dark })
hl('NeoTreeExpander', { fg = colors.fg_alt })

-- nvim-tree
hl('NvimTreeFolderIcon', { fg = colors.blue })
hl('NvimTreeFolderName', { fg = colors.blue, bold = true })
hl('NvimTreeOpenedFolderName', { fg = colors.blue, bold = true })
hl('NvimTreeEmptyFolderName', { fg = colors.blue })
hl('NvimTreeFileName', { fg = colors.fg })
hl('NvimTreeExecFile', { fg = colors.green })
hl('NvimTreeSpecialFile', { fg = colors.yellow })
hl('NvimTreeSymlink', { fg = colors.cyan })
hl('NvimTreeImageFile', { fg = colors.magenta })
hl('NvimTreeMarkdownFile', { fg = colors.fg_alt })
hl('NvimTreeGitDirty', { fg = colors.orange })
hl('NvimTreeGitNew', { fg = colors.green })
hl('NvimTreeGitDeleted', { fg = colors.red })
hl('NvimTreeGitMerge', { fg = colors.coral })
hl('NvimTreeGitRenamed', { fg = colors.purple })
hl('NvimTreeGitStaged', { fg = colors.green })
hl('NvimTreeIndentMarker', { fg = colors.fg_dark })
hl('NvimTreeRootFolder', { fg = colors.blue, bold = true })

-- Trouble (diagnostics)
hl('TroubleText', { fg = colors.fg })
hl('TroubleCount', { fg = colors.coral, bg = colors.bg_alt })
hl('TroubleNormal', { fg = colors.fg, bg = colors.bg })
hl('TroubleError', { fg = colors.error })
hl('TroubleWarning', { fg = colors.warning })
hl('TroubleInformation', { fg = colors.info })
hl('TroubleHint', { fg = colors.hint })
hl('TroubleSource', { fg = colors.fg_alt })
hl('TroubleCode', { fg = colors.fg_alt })
hl('TroubleLocation', { fg = colors.fg_alt })
hl('TroubleFile', { fg = colors.blue })
hl('TroubleSignError', { fg = colors.error })
hl('TroubleSignWarning', { fg = colors.warning })
hl('TroubleSignInformation', { fg = colors.info })
hl('TroubleSignHint', { fg = colors.hint })

-- Hop (motion)
hl('HopNextKey', { fg = colors.orange, bold = true })
hl('HopNextKey1', { fg = colors.blue, bold = true })
hl('HopNextKey2', { fg = colors.cyan })
hl('HopUnmatched', { fg = colors.fg_dark })

-- Indent Blankline
hl('IblIndent', { fg = colors.bg_light, nocombine = true })
hl('IblWhitespace', { fg = colors.bg_light, nocombine = true })
hl('IblScope', { fg = colors.fg_dark, nocombine = true })

-- Dashboard
hl('DashboardShortCut', { fg = colors.coral })
hl('DashboardHeader', { fg = colors.blue })
hl('DashboardCenter', { fg = colors.green })
hl('DashboardFooter', { fg = colors.yellow, italic = true })

-- Alpha (start screen)
hl('AlphaShortcut', { fg = colors.coral })
hl('AlphaHeader', { fg = colors.blue })
hl('AlphaHeaderLabel', { fg = colors.orange })
hl('AlphaFooter', { fg = colors.yellow })
hl('AlphaButtons', { fg = colors.cyan })

-- BufferLine
hl('BufferLineIndicatorSelected', { fg = colors.blue })
hl('BufferLineFill', { bg = colors.bg_dark })

-- ToggleTerm
hl('ToggleTerm1FloatBorder', { fg = colors.border, bg = colors.bg })
hl('ToggleTerm2FloatBorder', { fg = colors.border, bg = colors.bg })
hl('ToggleTerm3FloatBorder', { fg = colors.border, bg = colors.bg })

-- Aerial (symbols outline)
hl('AerialLine', { bg = colors.cursor_line })
hl('AerialGuide', { fg = colors.fg_dark })
hl('AerialArrayIcon', { fg = colors.orange })
hl('AerialBooleanIcon', { fg = colors.red })
hl('AerialClassIcon', { fg = colors.yellow })
hl('AerialConstantIcon', { fg = colors.red })
hl('AerialConstructorIcon', { fg = colors.yellow })
hl('AerialEnumIcon', { fg = colors.yellow })
hl('AerialEnumMemberIcon', { fg = colors.cyan })
hl('AerialEventIcon', { fg = colors.orange })
hl('AerialFieldIcon', { fg = colors.cyan })
hl('AerialFileIcon', { fg = colors.blue })
hl('AerialFunctionIcon', { fg = colors.blue })
hl('AerialInterfaceIcon', { fg = colors.yellow })
hl('AerialKeyIcon', { fg = colors.coral })
hl('AerialMethodIcon', { fg = colors.blue })
hl('AerialModuleIcon', { fg = colors.cyan })
hl('AerialNamespaceIcon', { fg = colors.cyan })
hl('AerialNullIcon', { fg = colors.red })
hl('AerialNumberIcon', { fg = colors.red })
hl('AerialObjectIcon', { fg = colors.yellow })
hl('AerialOperatorIcon', { fg = colors.fg })
hl('AerialPackageIcon', { fg = colors.cyan })
hl('AerialPropertyIcon', { fg = colors.cyan })
hl('AerialStringIcon', { fg = colors.green })
hl('AerialStructIcon', { fg = colors.yellow })
hl('AerialTypeParameterIcon', { fg = colors.yellow })
hl('AerialVariableIcon', { fg = colors.cyan })

-- Symbols outline
hl('SymbolsOutlineConnector', { fg = colors.fg_dark })
hl('FocusedSymbol', { bg = colors.cursor_line })

-- Lightbulb (code actions)
hl('LightBulbSign', { fg = colors.yellow })
hl('LightBulbFloatWin', { fg = colors.yellow, bg = colors.bg })
hl('LightBulbVirtualText', { fg = colors.yellow })

-- Fidget (LSP progress)
hl('FidgetTitle', { fg = colors.blue, bold = true })
hl('FidgetTask', { fg = colors.fg })

-- Noice (UI improvements)
hl('NoiceCmdline', { fg = colors.fg, bg = colors.bg })
hl('NoiceCmdlineIcon', { fg = colors.blue })
hl('NoiceCmdlineIconCmdline', { fg = colors.blue })
hl('NoiceCmdlineIconFilter', { fg = colors.coral })
hl('NoiceCmdlineIconHelp', { fg = colors.cyan })
hl('NoiceCmdlineIconIncRename', { fg = colors.orange })
hl('NoiceCmdlineIconInput', { fg = colors.green })
hl('NoiceCmdlineIconLua', { fg = colors.magenta })
hl('NoiceCmdlineIconSearch', { fg = colors.yellow })
hl('NoiceCmdlinePopup', { fg = colors.fg, bg = colors.bg })
hl('NoiceCmdlinePopupBorder', { fg = colors.border, bg = colors.bg })
hl('NoiceCmdlinePopupTitle', { fg = colors.blue, bg = colors.bg })
hl('NoiceCompletionItemKindDefault', { fg = colors.fg_alt, bg = colors.bg })

-- Flash (jump/search)
hl('FlashBackdrop', { fg = colors.fg_dark })
hl('FlashMatch', { fg = colors.bg, bg = colors.orange })
hl('FlashCurrent', { fg = colors.bg, bg = colors.blue })
hl('FlashLabel', { fg = colors.bg, bg = colors.coral, bold = true })
hl('FlashPrompt', { fg = colors.fg, bg = colors.bg })
hl('FlashPromptIcon', { fg = colors.blue, bg = colors.bg })

-- Leap (motion)
hl('LeapMatch', { fg = colors.bg, bg = colors.orange, bold = true })
hl('LeapLabelPrimary', { fg = colors.bg, bg = colors.coral, bold = true })
hl('LeapLabelSecondary', { fg = colors.bg, bg = colors.blue, bold = true })
hl('LeapBackdrop', { fg = colors.fg_dark })

-- Surround
hl('NvimSurroundHighlight', { bg = colors.cursor_line })

-- Rainbow delimiters
hl('RainbowDelimiterRed', { fg = colors.red })
hl('RainbowDelimiterYellow', { fg = colors.yellow })
hl('RainbowDelimiterBlue', { fg = colors.blue })
hl('RainbowDelimiterOrange', { fg = colors.orange })
hl('RainbowDelimiterGreen', { fg = colors.green })
hl('RainbowDelimiterViolet', { fg = colors.magenta })
hl('RainbowDelimiterCyan', { fg = colors.cyan })

-- Nvim-dap (debugger)
hl('DapBreakpoint', { fg = colors.red })
hl('DapBreakpointCondition', { fg = colors.orange })
hl('DapLogPoint', { fg = colors.blue })
hl('DapStopped', { fg = colors.green })
hl('DapBreakpointRejected', { fg = colors.fg_dark })

-- Nvim-dap-ui
hl('DapUIVariable', { fg = colors.fg })
hl('DapUIScope', { fg = colors.blue })
hl('DapUIType', { fg = colors.yellow })
hl('DapUIValue', { fg = colors.green })
hl('DapUIModifiedValue', { fg = colors.orange, bold = true })
hl('DapUIDecoration', { fg = colors.blue })
hl('DapUIThread', { fg = colors.green })
hl('DapUIStoppedThread', { fg = colors.red })
hl('DapUIFrameName', { fg = colors.fg })
hl('DapUISource', { fg = colors.yellow })
hl('DapUILineNumber', { fg = colors.blue })
hl('DapUIFloatBorder', { fg = colors.border, bg = colors.bg })
hl('DapUIWatchesEmpty', { fg = colors.red })
hl('DapUIWatchesValue', { fg = colors.green })
hl('DapUIWatchesError', { fg = colors.error })
hl('DapUIBreakpointsPath', { fg = colors.cyan })
hl('DapUIBreakpointsInfo', { fg = colors.green })
hl('DapUIBreakpointsCurrentLine', { fg = colors.green, bold = true })
hl('DapUIBreakpointsLine', { fg = colors.blue })
hl('DapUIBreakpointsDisabledLine', { fg = colors.fg_dark })
hl('DapUICurrentFrameName', { fg = colors.green, bold = true })
hl('DapUIStepOver', { fg = colors.blue })
hl('DapUIStepInto', { fg = colors.blue })
hl('DapUIStepBack', { fg = colors.blue })
hl('DapUIStepOut', { fg = colors.blue })
hl('DapUIStop', { fg = colors.red })
hl('DapUIPlayPause', { fg = colors.green })
hl('DapUIRestart', { fg = colors.green })
hl('DapUIUnavailable', { fg = colors.fg_dark })

-- Diffview
hl('DiffviewPrimary', { fg = colors.blue })
hl('DiffviewSecondary', { fg = colors.coral })
hl('DiffviewDiffAdd', { fg = colors.git_add })
hl('DiffviewDiffChange', { fg = colors.git_change })
hl('DiffviewDiffDelete', { fg = colors.git_delete })
hl('DiffviewDiffText', { fg = colors.bg, bg = colors.git_change })
hl('DiffviewDiffAddAsDelete', { fg = colors.git_delete })
hl('DiffviewDiffDeleteText', { fg = colors.git_delete })
hl('DiffviewEndOfBuffer', { fg = colors.bg })
hl('DiffviewFilePanelTitle', { fg = colors.blue, bold = true })
hl('DiffviewFilePanelCounter', { fg = colors.cyan })
hl('DiffviewFilePanelFileName', { fg = colors.fg })
hl('DiffviewNormal', { fg = colors.fg, bg = colors.bg })
hl('DiffviewCursorLine', { bg = colors.cursor_line })
hl('DiffviewVertSplit', { fg = colors.border, bg = colors.bg })
hl('DiffviewSignColumn', { bg = colors.bg })
hl('DiffviewStatusLine', { fg = colors.fg, bg = colors.bg_alt })
hl('DiffviewStatusLineNC', { fg = colors.fg_dark, bg = colors.bg_alt })
hl('DiffviewWinSeparator', { fg = colors.border, bg = colors.bg })
hl('DiffviewFolderName', { fg = colors.blue })
hl('DiffviewFolderSign', { fg = colors.blue })
hl('DiffviewReference', { fg = colors.blue })
hl('DiffviewBranchName', { fg = colors.coral })
hl('DiffviewCommitAuthor', { fg = colors.cyan })
hl('DiffviewDate', { fg = colors.yellow })
hl('DiffviewDescription', { fg = colors.fg })
hl('DiffviewDirectorySign', { fg = colors.blue })
hl('DiffviewFileHistory', { fg = colors.green })
hl('DiffviewHash', { fg = colors.purple })

-- ============================================================================
-- ADDITIONAL UI ELEMENTS AND EDGE CASES
-- ============================================================================

-- Cursor line/column when not in focus
hl('CursorLineNrNC', { fg = colors.fg_dark, bg = colors.bg })

-- Window highlights
hl('NormalSB', { fg = colors.fg, bg = colors.bg_alt })
hl('FloatShadow', { bg = colors.bg_dark, blend = 80 })
hl('FloatShadowThrough', { bg = colors.bg_dark, blend = 100 })

-- Health check
hl('healthError', { fg = colors.error })
hl('healthSuccess', { fg = colors.ok })
hl('healthWarning', { fg = colors.warning })

-- Man pages
hl('manBold', { fg = colors.blue, bold = true })
hl('manItalic', { fg = colors.coral, italic = true })
hl('manOptionDesc', { fg = colors.green })
hl('manReference', { fg = colors.cyan, underline = true })
hl('manSectionHeading', { fg = colors.yellow, bold = true })
hl('manSubHeading', { fg = colors.coral, bold = true })

-- Help files
hl('helpCommand', { fg = colors.green })
hl('helpExample', { fg = colors.cyan })
hl('helpHeader', { fg = colors.blue, bold = true })
hl('helpSectionDelim', { fg = colors.fg_dark })
hl('helpHyperTextJump', { fg = colors.blue, underline = true })
hl('helpHyperTextEntry', { fg = colors.coral })
hl('helpOption', { fg = colors.yellow })
hl('helpNote', { fg = colors.info })
hl('helpWarning', { fg = colors.warning })
hl('helpDeprecated', { fg = colors.error, strikethrough = true })

-- Checkhealth
hl('checkHealthError', { fg = colors.error })
hl('checkHealthSuccess', { fg = colors.ok })
hl('checkHealthWarning', { fg = colors.warning })

-- Neovim builtin terminal
hl('TermCursorNC', { fg = colors.bg, bg = colors.fg_dark })

-- ============================================================================
-- WEB DEVELOPMENT SPECIFIC HIGHLIGHTS
-- ============================================================================

-- React/JSX
hl('@tag.jsx', { fg = colors.coral })
hl('@tag.tsx', { fg = colors.coral })
hl('@tag.attribute.jsx', { fg = colors.blue })
hl('@tag.attribute.tsx', { fg = colors.blue })
hl('@constructor.jsx', { fg = colors.yellow })
hl('@constructor.tsx', { fg = colors.yellow })

-- Vue.js
hl('@tag.vue', { fg = colors.coral })
hl('@tag.attribute.vue', { fg = colors.blue })

-- Svelte
hl('@tag.svelte', { fg = colors.coral })
hl('@tag.attribute.svelte', { fg = colors.blue })

-- SCSS/Sass
hl('@variable.scss', { fg = colors.cyan })
hl('@variable.sass', { fg = colors.cyan })
hl('@function.scss', { fg = colors.blue })
hl('@function.sass', { fg = colors.blue })
hl('@property.scss', { fg = colors.blue })
hl('@property.sass', { fg = colors.blue })

-- Less
hl('@variable.less', { fg = colors.cyan })
hl('@function.less', { fg = colors.blue })
hl('@property.less', { fg = colors.blue })

-- Stylus
hl('@variable.stylus', { fg = colors.cyan })
hl('@function.stylus', { fg = colors.blue })
hl('@property.stylus', { fg = colors.blue })

-- GraphQL
hl('@keyword.graphql', { fg = colors.coral })
hl('@type.graphql', { fg = colors.yellow })
hl('@field.graphql', { fg = colors.cyan })

-- ============================================================================
-- DATA AND CONFIG FILE FORMATS
-- ============================================================================

-- INI files
hl('@field.ini', { fg = colors.blue })
hl('@property.ini', { fg = colors.blue })
hl('@string.ini', { fg = colors.green })
hl('@comment.ini', { fg = colors.fg_dark, italic = true })

-- Properties files
hl('@field.properties', { fg = colors.blue })
hl('@string.properties', { fg = colors.green })

-- Env files
hl('@field.env', { fg = colors.blue })
hl('@string.env', { fg = colors.green })

-- Gitignore
hl('@comment.gitignore', { fg = colors.fg_dark, italic = true })

-- Requirements.txt
hl('@string.requirements', { fg = colors.green })
hl('@operator.requirements', { fg = colors.fg })

-- Package.json and similar
hl('@field.json', { fg = colors.blue })
hl('@string.json', { fg = colors.green })

-- ============================================================================
-- TERMINAL COLORS
-- ============================================================================

-- Set terminal colors for integrated terminal
vim.g.terminal_color_0 = colors.bg
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_5 = colors.magenta
vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_7 = colors.fg
vim.g.terminal_color_8 = colors.fg_dark
vim.g.terminal_color_9 = colors.red
vim.g.terminal_color_10 = colors.green
vim.g.terminal_color_11 = colors.yellow
vim.g.terminal_color_12 = colors.blue
vim.g.terminal_color_13 = colors.magenta
vim.g.terminal_color_14 = colors.cyan
vim.g.terminal_color_15 = colors.fg_light

-- ============================================================================
-- FINAL SAFETY CHECKS AND AUTOCMDS
-- ============================================================================

-- Ensure Normal highlight is always properly set
vim.schedule(function()
  vim.cmd('highlight! Normal guifg=' .. colors.fg .. ' guibg=' .. colors.bg)
  vim.cmd('highlight! NormalNC guifg=' .. colors.fg .. ' guibg=' .. colors.bg)
end)

-- Set up highlight group for custom signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
    -- Optional: configure line highlighting
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
    -- Optional: configure number column highlighting
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
})
-- Additional performance optimization
vim.cmd('syntax sync minlines=200')
