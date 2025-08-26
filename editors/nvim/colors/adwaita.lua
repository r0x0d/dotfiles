-- adwaita_dark.lua
-- A custom Neovim colorscheme designed for GNOME Terminal and Adwaita theme
-- Place this file in ~/.config/nvim/colors/ and use with :colorscheme adwaita_dark

-- Clear existing highlights
vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd 'syntax reset'
end

vim.o.termguicolors = true
vim.g.colors_name = 'adwaita'

-- Color palette inspired by konsole.lua but adapted for GNOME Terminal
local colors = {
  -- Base colors matching GNOME Terminal background but with konsole-style colors
  bg = '#1d1d20', -- Main background (GNOME Terminal default)
  bg_alt = '#2d2d2d', -- Slightly lighter background
  bg_light = '#353535', -- Lighter background for selections

  fg = '#eff0f1', -- Main foreground (light gray from konsole)
  fg_alt = '#bdc3c7', -- Dimmer foreground (from konsole)
  fg_dark = '#7f8c8d', -- Dark foreground for comments (from konsole)

  -- Accent colors from konsole palette
  blue = '#3daee9', -- KDE blue accent
  cyan = '#16a085', -- Teal cyan
  green = '#37ad82', -- Fresh green (inspired by sitruuna)
  yellow = '#FAC03B', -- Bright lemon yellow (from sitruuna)
  orange = '#ffb354', -- Warm orange (from sitruuna)
  red = '#c15959', -- Soft red (from sitruuna)
  coral = '#ca70d6', -- Coral/pink (replacing purple, from sitruuna)
  magenta = '#a29bfe', -- Light lavender (from sitruuna)

  -- UI colors adapted from konsole
  border = '#34495e', -- Borders and separators
  selection = '#34495e', -- Visual selections
  search = '#f39c12', -- Search highlights
  match_paren = '#3daee9', -- Matching parentheses

  -- Git colors from konsole
  git_add = '#37ad82', -- Added lines (sitruuna green)
  git_change = '#FAC03B', -- Changed lines (sitruuna yellow)
  git_delete = '#c15959', -- Deleted lines (sitruuna red)

  -- Diagnostic colors from konsole
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

-- Enhanced Tree-sitter highlights for YAML
hl('@field.yaml', { fg = colors.blue }) -- Keys/properties
hl('@property.yaml', { fg = colors.blue }) -- Alternative for keys
hl('@string.yaml', { fg = colors.green }) -- String values
hl('@number.yaml', { fg = colors.red }) -- Numbers
hl('@boolean.yaml', { fg = colors.red }) -- true/false
hl('@constant.builtin.yaml', { fg = colors.red }) -- null
hl('@punctuation.delimiter.yaml', { fg = colors.fg_alt }) -- Colons, commas
hl('@punctuation.special.yaml', { fg = colors.coral }) -- Dashes, pipe operators
hl('@operator.yaml', { fg = colors.coral }) -- YAML operators like |, >
hl('@type.yaml', { fg = colors.yellow }) -- Types and tags
hl('@tag.yaml', { fg = colors.magenta }) -- YAML tags like !!str
hl('@label.yaml', { fg = colors.cyan }) -- Anchors and aliases

-- Enhanced Tree-sitter highlights for JSON
hl('@field.json', { fg = colors.blue }) -- Object keys
hl('@property.json', { fg = colors.blue }) -- Alternative for keys
hl('@string.json', { fg = colors.green }) -- String values
hl('@number.json', { fg = colors.red }) -- Numbers
hl('@boolean.json', { fg = colors.red }) -- true/false
hl('@constant.builtin.json', { fg = colors.red }) -- null
hl('@punctuation.bracket.json', { fg = colors.fg }) -- Brackets and braces
hl('@punctuation.delimiter.json', { fg = colors.fg_alt }) -- Colons and commas

-- TOML support (bonus)
hl('@field.toml', { fg = colors.blue })
hl('@property.toml', { fg = colors.blue })
hl('@string.toml', { fg = colors.green })
hl('@number.toml', { fg = colors.red })
hl('@boolean.toml', { fg = colors.red })
hl('@constant.builtin.toml', { fg = colors.red })
hl('@type.toml', { fg = colors.yellow }) -- Section headers
hl('@punctuation.delimiter.toml', { fg = colors.fg_alt })
hl('@punctuation.bracket.toml', { fg = colors.fg })

-- XML/HTML improvements
hl('@tag.xml', { fg = colors.coral })
hl('@tag.html', { fg = colors.coral })
hl('@tag.attribute.xml', { fg = colors.blue })
hl('@tag.attribute.html', { fg = colors.blue })
hl('@string.xml', { fg = colors.green })
hl('@string.html', { fg = colors.green })

-- Markdown improvements
hl('@markup.heading.1.markdown', { fg = colors.blue, bold = true })
hl('@markup.heading.2.markdown', { fg = colors.coral, bold = true })
hl('@markup.heading.3.markdown', { fg = colors.green, bold = true })
hl('@markup.heading.4.markdown', { fg = colors.yellow, bold = true })
hl('@markup.heading.5.markdown', { fg = colors.cyan, bold = true })
hl('@markup.heading.6.markdown', { fg = colors.magenta, bold = true })
hl('@markup.list.markdown', { fg = colors.coral }) -- List markers
hl('@markup.link.markdown', { fg = colors.blue, underline = true })
hl('@markup.raw.markdown', { fg = colors.green }) -- Code blocks
hl('@markup.raw.inline.markdown', { fg = colors.green }) -- Inline code
hl('@markup.quote.markdown', { fg = colors.fg_alt, italic = true })
hl('@markup.strong.markdown', { fg = colors.fg, bold = true })
hl('@markup.italic.markdown', { fg = colors.fg, italic = true })

-- COMPREHENSIVE DOCKER/CONTAINERFILE IMPROVEMENTS
-- Tree-sitter highlights for Docker files
hl('@keyword.dockerfile', { fg = colors.coral, bold = true }) -- FROM, RUN, COPY, ADD, etc.
hl('@keyword.instruction.dockerfile', { fg = colors.coral, bold = true }) -- All Dockerfile instructions
hl('@string.dockerfile', { fg = colors.green }) -- Quoted strings
hl('@string.plain.dockerfile', { fg = colors.green }) -- Unquoted strings
hl('@string.quoted.dockerfile', { fg = colors.green }) -- Explicitly quoted strings
hl('@variable.dockerfile', { fg = colors.cyan }) -- Environment variables like $VAR, ${VAR}
hl('@variable.builtin.dockerfile', { fg = colors.red }) -- Built-in variables
hl('@variable.parameter.dockerfile', { fg = colors.cyan }) -- Parameter variables
hl('@constant.dockerfile', { fg = colors.red }) -- Constants and literal values
hl('@number.dockerfile', { fg = colors.red }) -- Port numbers, version numbers
hl('@operator.dockerfile', { fg = colors.fg }) -- Operators like =, :
hl('@punctuation.dockerfile', { fg = colors.fg_alt }) -- General punctuation
hl('@punctuation.delimiter.dockerfile', { fg = colors.fg_alt }) -- Delimiters like commas
hl('@punctuation.bracket.dockerfile', { fg = colors.fg }) -- Brackets and braces
hl('@punctuation.special.dockerfile', { fg = colors.orange }) -- Special characters like $, {, }
hl('@comment.dockerfile', { fg = colors.fg_dark, italic = true }) -- Comments
hl('@function.dockerfile', { fg = colors.blue }) -- Function-like constructs
hl('@parameter.dockerfile', { fg = colors.cyan }) -- Parameters in instructions
hl('@field.dockerfile', { fg = colors.blue }) -- Field names in key=value pairs
hl('@property.dockerfile', { fg = colors.blue }) -- Properties
hl('@label.dockerfile', { fg = colors.yellow }) -- Labels and metadata
hl('@flag.dockerfile', { fg = colors.magenta }) -- Command flags like --from, --chown
hl('@option.dockerfile', { fg = colors.magenta }) -- Options and flags
hl('@path.dockerfile', { fg = colors.green }) -- File paths
hl('@url.dockerfile', { fg = colors.cyan, underline = true }) -- URLs
hl('@tag.dockerfile', { fg = colors.yellow }) -- Image tags
hl('@namespace.dockerfile', { fg = colors.cyan }) -- Namespaces and registries

-- Traditional vim syntax highlighting for Dockerfile (fallback support)
hl('dockerfileKeyword', { fg = colors.coral, bold = true }) -- FROM, RUN, COPY, etc.
hl('dockerfileString', { fg = colors.green }) -- Quoted strings
hl('dockerfileComment', { fg = colors.fg_dark, italic = true }) -- Comments
hl('dockerfileEnv', { fg = colors.cyan }) -- Environment variables
hl('dockerfilePort', { fg = colors.red }) -- Port numbers
hl('dockerfileVolume', { fg = colors.blue }) -- Volume paths
hl('dockerfileExpose', { fg = colors.red }) -- EXPOSE instruction
hl('dockerfileLabel', { fg = colors.yellow }) -- LABEL values
hl('dockerfileOnbuild', { fg = colors.orange }) -- ONBUILD instruction
hl('dockerfileHealthcheck', { fg = colors.magenta }) -- HEALTHCHECK instruction
hl('dockerfileOption', { fg = colors.magenta }) -- Command options and flags
hl('dockerfileFlag', { fg = colors.magenta }) -- Flags like --from, --chown
hl('dockerfilePath', { fg = colors.green }) -- File paths
hl('dockerfileUrl', { fg = colors.cyan, underline = true }) -- URLs
hl('dockerfileImageName', { fg = colors.yellow }) -- Image names
hl('dockerfileImageTag', { fg = colors.yellow }) -- Image tags
hl('dockerfileRegistry', { fg = colors.cyan }) -- Registry names
hl('dockerfileInstruction', { fg = colors.coral, bold = true }) -- All instructions
hl('dockerfileVariable', { fg = colors.cyan }) -- Variables in ${} format
hl('dockerfileSpecialChar', { fg = colors.orange }) -- Special characters
hl('dockerfileEscape', { fg = colors.orange }) -- Escape characters
hl('dockerfileCmdParam', { fg = colors.fg_alt }) -- CMD parameters
hl('dockerfileEntrypointParam', { fg = colors.fg_alt }) -- ENTRYPOINT parameters
hl('dockerfileRunParam', { fg = colors.fg_alt }) -- RUN command parameters
hl('dockerfileCopyParam', { fg = colors.fg_alt }) -- COPY command parameters
hl('dockerfileAddParam', { fg = colors.fg_alt }) -- ADD command parameters

-- Docker-compose support (bonus)
hl('@field.docker-compose', { fg = colors.blue }) -- Service names, keys
hl('@string.docker-compose', { fg = colors.green }) -- String values
hl('@number.docker-compose', { fg = colors.red }) -- Port numbers, versions
hl('@boolean.docker-compose', { fg = colors.red }) -- true/false
hl('dockerComposeKeyword', { fg = colors.coral }) -- version, services, etc.
hl('dockerComposeString', { fg = colors.green }) -- Quoted strings
hl('dockerComposeComment', { fg = colors.fg_dark, italic = true }) -- Comments
hl('dockerComposePort', { fg = colors.red }) -- Port mappings
hl('dockerComposeVolume', { fg = colors.blue }) -- Volume definitions
hl('dockerComposeEnvironment', { fg = colors.cyan }) -- Environment variables

-- Shell script improvements
hl('@keyword.bash', { fg = colors.coral })
hl('@function.bash', { fg = colors.blue })
hl('@variable.bash', { fg = colors.cyan })
hl('@string.bash', { fg = colors.green })
hl('@punctuation.special.bash', { fg = colors.orange }) -- $, ${}, etc.

-- CSS improvements
hl('@property.css', { fg = colors.blue }) -- CSS properties
hl('@string.css', { fg = colors.green }) -- String values
hl('@number.css', { fg = colors.red }) -- Numbers and units
hl('@type.css', { fg = colors.coral }) -- Selectors
hl('@function.css', { fg = colors.yellow }) -- Functions like rgb()
hl('@punctuation.delimiter.css', { fg = colors.fg_alt })

-- JavaScript/TypeScript improvements
hl('@constructor.javascript', { fg = colors.yellow })
hl('@constructor.typescript', { fg = colors.yellow })
hl('@variable.member.javascript', { fg = colors.cyan })
hl('@variable.member.typescript', { fg = colors.cyan })
hl('@keyword.import.javascript', { fg = colors.coral })
hl('@keyword.import.typescript', { fg = colors.coral })
hl('@keyword.export.javascript', { fg = colors.coral })
hl('@keyword.export.typescript', { fg = colors.coral })

-- Python improvements
hl('@keyword.import.python', { fg = colors.coral })
hl('@constructor.python', { fg = colors.yellow })
hl('@variable.member.python', { fg = colors.cyan })
hl('@function.builtin.python', { fg = colors.blue })
hl('@constant.builtin.python', { fg = colors.red }) -- True, False, None

-- Go improvements
hl('@keyword.go', { fg = colors.coral }) -- func, var, const, etc.
hl('@keyword.import.go', { fg = colors.coral }) -- import
hl('@type.builtin.go', { fg = colors.yellow }) -- int, string, bool, etc.
hl('@function.go', { fg = colors.blue }) -- Function names
hl('@variable.go', { fg = colors.cyan }) -- Variables
hl('@constant.go', { fg = colors.red }) -- Constants
hl('@string.go', { fg = colors.green }) -- Strings
hl('@operator.go', { fg = colors.fg }) -- Operators
hl('@punctuation.delimiter.go', { fg = colors.fg_alt }) -- Commas, semicolons

-- Rust improvements
hl('@keyword.rust', { fg = colors.coral }) -- fn, let, mut, etc.
hl('@keyword.import.rust', { fg = colors.coral }) -- use
hl('@type.rust', { fg = colors.yellow }) -- Custom types
hl('@type.builtin.rust', { fg = colors.yellow }) -- i32, u64, String, etc.
hl('@function.rust', { fg = colors.blue }) -- Function names
hl('@variable.rust', { fg = colors.cyan }) -- Variables
hl('@constant.rust', { fg = colors.red }) -- Constants
hl('@string.rust', { fg = colors.green }) -- Strings
hl('@attribute.rust', { fg = colors.magenta }) -- #[derive], #[cfg], etc.
hl('@punctuation.delimiter.rust', { fg = colors.fg_alt }) -- Commas, semicolons
hl('@operator.rust', { fg = colors.fg }) -- Operators

-- Java improvements
hl('@keyword.java', { fg = colors.coral }) -- class, public, private, etc.
hl('@keyword.import.java', { fg = colors.coral }) -- import
hl('@type.java', { fg = colors.yellow }) -- Class names
hl('@type.builtin.java', { fg = colors.yellow }) -- int, String, boolean, etc.
hl('@function.java', { fg = colors.blue }) -- Method names
hl('@variable.java', { fg = colors.cyan }) -- Variables
hl('@constant.java', { fg = colors.red }) -- Constants
hl('@string.java', { fg = colors.green }) -- Strings
hl('@annotation.java', { fg = colors.magenta }) -- @Override, @Deprecated, etc.
hl('@punctuation.delimiter.java', { fg = colors.fg_alt }) -- Commas, semicolons

-- C improvements
hl('@keyword.c', { fg = colors.coral }) -- int, char, if, for, etc.
hl('@keyword.import.c', { fg = colors.coral }) -- #include
hl('@type.c', { fg = colors.yellow }) -- Custom types
hl('@type.builtin.c', { fg = colors.yellow }) -- int, char, float, etc.
hl('@function.c', { fg = colors.blue }) -- Function names
hl('@variable.c', { fg = colors.cyan }) -- Variables
hl('@constant.c', { fg = colors.red }) -- Constants
hl('@string.c', { fg = colors.green }) -- Strings
hl('@preproc.c', { fg = colors.magenta }) -- Preprocessor directives
hl('@punctuation.delimiter.c', { fg = colors.fg_alt }) -- Commas, semicolons

-- C++ improvements
hl('@keyword.cpp', { fg = colors.coral }) -- class, namespace, template, etc.
hl('@keyword.import.cpp', { fg = colors.coral }) -- #include, using
hl('@type.cpp', { fg = colors.yellow }) -- Custom types
hl('@type.builtin.cpp', { fg = colors.yellow }) -- int, std::string, etc.
hl('@function.cpp', { fg = colors.blue }) -- Function names
hl('@variable.cpp', { fg = colors.cyan }) -- Variables
hl('@constant.cpp', { fg = colors.red }) -- Constants
hl('@string.cpp', { fg = colors.green }) -- Strings
hl('@namespace.cpp', { fg = colors.cyan }) -- std, etc.
hl('@preproc.cpp', { fg = colors.magenta }) -- Preprocessor directives
hl('@punctuation.delimiter.cpp', { fg = colors.fg_alt }) -- Commas, semicolons

-- C# improvements
hl('@keyword.cs', { fg = colors.coral }) -- class, using, namespace, etc.
hl('@keyword.import.cs', { fg = colors.coral }) -- using
hl('@type.cs', { fg = colors.yellow }) -- Custom types
hl('@type.builtin.cs', { fg = colors.yellow }) -- int, string, bool, etc.
hl('@function.cs', { fg = colors.blue }) -- Method names
hl('@variable.cs', { fg = colors.cyan }) -- Variables
hl('@constant.cs', { fg = colors.red }) -- Constants
hl('@string.cs', { fg = colors.green }) -- Strings
hl('@attribute.cs', { fg = colors.magenta }) -- [Attribute]
hl('@punctuation.delimiter.cs', { fg = colors.fg_alt }) -- Commas, semicolons

-- PHP improvements
hl('@keyword.php', { fg = colors.coral }) -- class, function, if, etc.
hl('@keyword.import.php', { fg = colors.coral }) -- use, require, include
hl('@type.php', { fg = colors.yellow }) -- Custom types
hl('@function.php', { fg = colors.blue }) -- Function names
hl('@variable.php', { fg = colors.cyan }) -- Variables (including $)
hl('@constant.php', { fg = colors.red }) -- Constants
hl('@string.php', { fg = colors.green }) -- Strings
hl('@variable.builtin.php', { fg = colors.red }) -- $this, $_GET, etc.
hl('@punctuation.delimiter.php', { fg = colors.fg_alt }) -- Commas, semicolons

-- Ruby improvements
hl('@keyword.ruby', { fg = colors.coral }) -- def, class, if, etc.
hl('@keyword.import.ruby', { fg = colors.coral }) -- require, include
hl('@type.ruby', { fg = colors.yellow }) -- Class names
hl('@function.ruby', { fg = colors.blue }) -- Method names
hl('@variable.ruby', { fg = colors.cyan }) -- Variables
hl('@constant.ruby', { fg = colors.red }) -- Constants
hl('@string.ruby', { fg = colors.green }) -- Strings
hl('@symbol.ruby', { fg = colors.orange }) -- :symbol
hl('@variable.builtin.ruby', { fg = colors.red }) -- self, super
hl('@punctuation.delimiter.ruby', { fg = colors.fg_alt }) -- Commas, etc.

-- Swift improvements
hl('@keyword.swift', { fg = colors.coral }) -- func, class, var, let, etc.
hl('@keyword.import.swift', { fg = colors.coral }) -- import
hl('@type.swift', { fg = colors.yellow }) -- Custom types
hl('@type.builtin.swift', { fg = colors.yellow }) -- Int, String, Bool, etc.
hl('@function.swift', { fg = colors.blue }) -- Function names
hl('@variable.swift', { fg = colors.cyan }) -- Variables
hl('@constant.swift', { fg = colors.red }) -- Constants
hl('@string.swift', { fg = colors.green }) -- Strings
hl('@attribute.swift', { fg = colors.magenta }) -- @objc, @available, etc.
hl('@punctuation.delimiter.swift', { fg = colors.fg_alt }) -- Commas, semicolons

-- Kotlin improvements
hl('@keyword.kotlin', { fg = colors.coral }) -- fun, class, val, var, etc.
hl('@keyword.import.kotlin', { fg = colors.coral }) -- import
hl('@type.kotlin', { fg = colors.yellow }) -- Custom types
hl('@type.builtin.kotlin', { fg = colors.yellow }) -- Int, String, Boolean, etc.
hl('@function.kotlin', { fg = colors.blue }) -- Function names
hl('@variable.kotlin', { fg = colors.cyan }) -- Variables
hl('@constant.kotlin', { fg = colors.red }) -- Constants
hl('@string.kotlin', { fg = colors.green }) -- Strings
hl('@annotation.kotlin', { fg = colors.magenta }) -- @JvmStatic, etc.
hl('@punctuation.delimiter.kotlin', { fg = colors.fg_alt }) -- Commas, semicolons

-- Dart improvements
hl('@keyword.dart', { fg = colors.coral }) -- class, void, if, etc.
hl('@keyword.import.dart', { fg = colors.coral }) -- import
hl('@type.dart', { fg = colors.yellow }) -- Custom types
hl('@type.builtin.dart', { fg = colors.yellow }) -- int, String, bool, etc.
hl('@function.dart', { fg = colors.blue }) -- Function names
hl('@variable.dart', { fg = colors.cyan }) -- Variables
hl('@constant.dart', { fg = colors.red }) -- Constants
hl('@string.dart', { fg = colors.green }) -- Strings
hl('@annotation.dart', { fg = colors.magenta }) -- @override, etc.
hl('@punctuation.delimiter.dart', { fg = colors.fg_alt }) -- Commas, semicolons

-- SQL improvements
hl('@keyword.sql', { fg = colors.coral }) -- SELECT, FROM, WHERE, etc.
hl('@type.sql', { fg = colors.yellow }) -- VARCHAR, INT, etc.
hl('@function.sql', { fg = colors.blue }) -- COUNT, SUM, etc.
hl('@string.sql', { fg = colors.green }) -- String literals
hl('@number.sql', { fg = colors.red }) -- Numbers
hl('@operator.sql', { fg = colors.fg }) -- =, <, >, etc.
hl('@punctuation.delimiter.sql', { fg = colors.fg_alt }) -- Commas, semicolons

-- Lua improvements (bonus for Neovim users)
hl('@keyword.lua', { fg = colors.coral }) -- function, local, if, etc.
hl('@function.lua', { fg = colors.blue }) -- Function names
hl('@variable.lua', { fg = colors.cyan }) -- Variables
hl('@constant.lua', { fg = colors.red }) -- Constants
hl('@string.lua', { fg = colors.green }) -- Strings
hl('@function.builtin.lua', { fg = colors.blue }) -- print, pairs, etc.
hl('@constant.builtin.lua', { fg = colors.red }) -- nil, true, false
hl('@punctuation.delimiter.lua', { fg = colors.fg_alt }) -- Commas, semicolons

-- Vim script improvements (bonus for Vim users)
hl('@keyword.vim', { fg = colors.coral }) -- function, let, if, etc.
hl('@function.vim', { fg = colors.blue }) -- Function names
hl('@variable.vim', { fg = colors.cyan }) -- Variables
hl('@constant.vim', { fg = colors.red }) -- Constants
hl('@string.vim', { fg = colors.green }) -- Strings
hl('@function.builtin.vim', { fg = colors.blue }) -- Built-in functions
hl('@punctuation.delimiter.vim', { fg = colors.fg_alt }) -- Commas, etc.

-- RPM spec file improvements
hl('@keyword.spec', { fg = colors.coral }) -- Section headers like %prep, %build, %install
hl('@function.spec', { fg = colors.blue }) -- RPM macros like %{name}, %{version}
hl('@variable.spec', { fg = colors.cyan }) -- Variables and substitutions
hl('@constant.spec', { fg = colors.red }) -- Version numbers, release numbers
hl('@string.spec', { fg = colors.green }) -- Quoted strings and descriptions
hl('@comment.spec', { fg = colors.fg_dark, italic = true }) -- Comments
hl('@type.spec', { fg = colors.yellow }) -- Package names, dependencies
hl('@operator.spec', { fg = colors.fg }) -- Operators like >=, <=, =
hl('@punctuation.spec', { fg = colors.fg_alt }) -- General punctuation
hl('@punctuation.delimiter.spec', { fg = colors.fg_alt }) -- Colons, commas
hl('@tag.spec', { fg = colors.orange }) -- Tags like Name:, Version:, Summary:
hl('@attribute.spec', { fg = colors.magenta }) -- Attributes and flags
hl('@number.spec', { fg = colors.red }) -- Numbers in versions, etc.

-- Traditional vim syntax for spec files (fallback)
hl('specSection', { fg = colors.coral, bold = true }) -- %prep, %build, %install, %files
hl('specSectionMacro', { fg = colors.coral, bold = true }) -- Section macros
hl('specMacro', { fg = colors.blue }) -- %{macro} constructs
hl('specVariables', { fg = colors.cyan }) -- $RPM_BUILD_ROOT, etc.
hl('specGlobalMacro', { fg = colors.blue }) -- Global macros
hl('specCommandOpts', { fg = colors.magenta }) -- Command line options
hl('specComment', { fg = colors.fg_dark, italic = true }) -- # Comments
hl('specConfigure', { fg = colors.yellow }) -- ./configure commands
hl('specTarCommand', { fg = colors.yellow }) -- tar commands
hl('specMake', { fg = colors.yellow }) -- make commands
hl('specInstall', { fg = colors.yellow }) -- install commands
hl('specRpmMacro', { fg = colors.blue }) -- RPM-specific macros
hl('specSpecialChar', { fg = colors.orange }) -- Special characters
hl('specSpecialVariables', { fg = colors.cyan }) -- Special RPM variables
hl('specSpecialVariablesNames', { fg = colors.cyan }) -- Variable names
hl('specListedFiles', { fg = colors.green }) -- Files in %files section
hl('specListedFilesPrefix', { fg = colors.magenta }) -- File prefixes like %config, %doc
hl('specFilesDir', { fg = colors.green }) -- Directory paths
hl('specAttr', { fg = colors.orange }) -- %attr() directives
hl('specDefine', { fg = colors.coral }) -- %define statements
hl('specDefineName', { fg = colors.blue }) -- Defined macro names
hl('specDefineValue', { fg = colors.green }) -- Defined macro values
hl('specGlobal', { fg = colors.coral }) -- %global statements
hl('specGlobalName', { fg = colors.blue }) -- Global macro names
hl('specGlobalValue', { fg = colors.green }) -- Global macro values
hl('specPackage', { fg = colors.yellow }) -- %package statements
hl('specPackageName', { fg = colors.yellow }) -- Package names
hl('specDescription', { fg = colors.green }) -- %description content
hl('specDescriptionOpts', { fg = colors.magenta }) -- %description options
hl('specChangelog', { fg = colors.fg_alt }) -- %changelog content
hl('specChangelogHeader', { fg = colors.blue }) -- Changelog headers
hl('specLicense', { fg = colors.green }) -- License field content
hl('specURL', { fg = colors.cyan, underline = true }) -- URLs
hl('specEmail', { fg = colors.cyan }) -- Email addresses
hl('specUnknown', { fg = colors.error }) -- Unknown/error constructs

-- Header fields (Name:, Version:, etc.)
hl('specTag', { fg = colors.orange, bold = true }) -- Header tags
hl('specTagName', { fg = colors.orange, bold = true }) -- Tag names
hl('specTagValue', { fg = colors.green }) -- Tag values
hl('specName', { fg = colors.yellow }) -- Package name
hl('specVersion', { fg = colors.red }) -- Version numbers
hl('specRelease', { fg = colors.red }) -- Release numbers
hl('specEpoch', { fg = colors.red }) -- Epoch numbers
hl('specSummary', { fg = colors.green }) -- Summary text
hl('specGroup', { fg = colors.yellow }) -- Group classification
hl('specSource', { fg = colors.cyan }) -- Source URLs/files
hl('specPatch', { fg = colors.magenta }) -- Patch files
hl('specBuildArch', { fg = colors.yellow }) -- BuildArch field
hl('specExclusiveArch', { fg = colors.yellow }) -- ExclusiveArch field
hl('specBuildRequires', { fg = colors.cyan }) -- BuildRequires dependencies
hl('specRequires', { fg = colors.cyan }) -- Runtime dependencies
hl('specProvides', { fg = colors.cyan }) -- Provided capabilities
hl('specObsoletes', { fg = colors.red }) -- Obsoleted packages
hl('specConflicts', { fg = colors.red }) -- Conflicting packages

-- Oil.nvim file explorer
hl('OilDir', { fg = colors.blue, bold = true }) -- Directories/folders
hl('OilDirIcon', { fg = colors.blue }) -- Directory icons
hl('OilLink', { fg = colors.cyan }) -- Symbolic links
hl('OilLinkTarget', { fg = colors.fg_alt }) -- Link targets
hl('OilCopy', { fg = colors.yellow }) -- Files being copied
hl('OilMove', { fg = colors.orange }) -- Files being moved
hl('OilChange', { fg = colors.coral }) -- Modified files
hl('OilCreate', { fg = colors.green }) -- New files
hl('OilDelete', { fg = colors.red }) -- Files to be deleted
hl('OilPermissionRead', { fg = colors.green }) -- Read permissions
hl('OilPermissionWrite', { fg = colors.yellow }) -- Write permissions
hl('OilPermissionExecute', { fg = colors.red }) -- Execute permissions
hl('OilTypeDir', { fg = colors.blue, bold = true }) -- Directory type indicator
hl('OilTypeFile', { fg = colors.fg }) -- Regular file type
hl('OilTypeLink', { fg = colors.cyan }) -- Link type indicator
hl('OilTypeSocket', { fg = colors.magenta }) -- Socket files
hl('OilTypeFifo', { fg = colors.orange }) -- FIFO/pipe files
hl('OilSize', { fg = colors.fg_alt }) -- File sizes
hl('OilMtime', { fg = colors.fg_dark }) -- Modification times
hl('OilRestore', { fg = colors.cyan }) -- Restore operations
hl('OilTrash', { fg = colors.red }) -- Trash operations
hl('OilTrashSourcePath', { fg = colors.fg_alt }) -- Original path of trashed files

-- Neo-tree file explorer (bonus support)
hl('NeoTreeDirectoryIcon', { fg = colors.blue }) -- Directory icons
hl('NeoTreeDirectoryName', { fg = colors.blue, bold = true }) -- Directory names
hl('NeoTreeFileName', { fg = colors.fg }) -- File names
hl('NeoTreeFileIcon', { fg = colors.fg_alt }) -- File icons
hl('NeoTreeModified', { fg = colors.orange }) -- Modified indicator
hl('NeoTreeGitAdded', { fg = colors.green }) -- Git added
hl('NeoTreeGitDeleted', { fg = colors.red }) -- Git deleted
hl('NeoTreeGitModified', { fg = colors.yellow }) -- Git modified
hl('NeoTreeGitConflict', { fg = colors.coral }) -- Git conflicts
hl('NeoTreeGitUntracked', { fg = colors.fg_dark }) -- Git untracked
hl('NeoTreeSymbolicLinkTarget', { fg = colors.cyan }) -- Symlink targets

-- nvim-tree file explorer (bonus support)
hl('NvimTreeFolderIcon', { fg = colors.blue }) -- Folder icons
hl('NvimTreeFolderName', { fg = colors.blue, bold = true }) -- Folder names
hl('NvimTreeOpenedFolderName', { fg = colors.blue, bold = true }) -- Opened folders
hl('NvimTreeEmptyFolderName', { fg = colors.blue }) -- Empty folders
hl('NvimTreeFileName', { fg = colors.fg }) -- File names
hl('NvimTreeExecFile', { fg = colors.green }) -- Executable files
hl('NvimTreeSpecialFile', { fg = colors.yellow }) -- Special files
hl('NvimTreeSymlink', { fg = colors.cyan }) -- Symbolic links
hl('NvimTreeImageFile', { fg = colors.magenta }) -- Image files
hl('NvimTreeMarkdownFile', { fg = colors.fg_alt }) -- Markdown files
hl('NvimTreeGitDirty', { fg = colors.orange }) -- Git dirty files
hl('NvimTreeGitNew', { fg = colors.green }) -- Git new files
hl('NvimTreeGitDeleted', { fg = colors.red }) -- Git deleted files
