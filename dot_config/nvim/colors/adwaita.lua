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

-- Properties table for consistent theming
local properties = {
  -- Variables and identifiers
  variables = 'NONE',
  
  -- Constants and literals
  constants = colors.red,
  numbers = colors.red,
  booleans = colors.red,
  characters = colors.green,
  
  -- Strings
  strings = colors.green,
  
  -- Functions and methods
  functions = colors.blue,
  methods = colors.blue,
  constructors = colors.yellow,
  
  -- Keywords and language constructs
  keywords = colors.coral,
  
  -- Types and classes
  types = colors.yellow,
  
  -- Comments
  comments = colors.fg_dark,
  
  -- Punctuation and operators
  punctuation = colors.fg_alt,
  operators = colors.fg,
  
  -- Tags and markup
  tags = colors.blue,
  attributes = colors.cyan,
  
  -- Markup elements (markdown, etc.)
  markup_headings = colors.blue,
  markup_emphasis = colors.fg,
  markup_links = colors.blue,
  markup_code = colors.green,
  
  -- Namespaces and modules
  namespaces = colors.cyan,
  
  -- Fields and properties
  fields = colors.blue,
  properties = colors.blue,
  
  -- Labels and annotations
  labels = colors.yellow,
  annotations = colors.magenta,
  
  -- Preprocessor directives
  preprocessor = colors.magenta,
  
  -- Symbols and special elements
  symbols = colors.orange,
  urls = colors.cyan,
  paths = colors.green,
  flags = colors.magenta,
  
  -- Special syntax elements
  string_escapes = colors.orange,
  macros = colors.magenta,
  special_punctuation = colors.orange
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
hl('@variable', { fg = properties.variables })
hl('@variable.builtin', { fg = properties.variables })
hl('@variable.parameter', { fg = properties.variables })
hl('@variable.member', { fg = properties.variables })

hl('@constant', { fg = properties.constants })
hl('@constant.builtin', { fg = properties.constants })
hl('@constant.macro', { fg = properties.constants }) -- Note: was colors.yellow, now unified

hl('@string', { fg = properties.strings })
hl('@string.escape', { fg = properties.string_escapes })
hl('@character', { fg = properties.characters })
hl('@number', { fg = properties.numbers })
hl('@boolean', { fg = properties.booleans })

hl('@function', { fg = properties.functions })
hl('@function.builtin', { fg = properties.functions })
hl('@function.macro', { fg = properties.macros })
hl('@method', { fg = properties.methods })
hl('@constructor', { fg = properties.constructors })

hl('@keyword', { fg = properties.keywords })
hl('@keyword.function', { fg = properties.keywords })
hl('@keyword.operator', { fg = properties.keywords })
hl('@keyword.return', { fg = properties.keywords })

hl('@type', { fg = properties.types })
hl('@type.builtin', { fg = properties.types })
hl('@namespace', { fg = properties.namespaces })

hl('@tag', { fg = properties.tags })
hl('@tag.attribute', { fg = properties.attributes })
hl('@tag.delimiter', { fg = properties.punctuation })

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
hl('@field.yaml', { fg = properties.fields }) -- Keys/properties
hl('@property.yaml', { fg = properties.properties }) -- Alternative for keys
hl('@string.yaml', { fg = properties.strings }) -- String values
hl('@number.yaml', { fg = properties.numbers }) -- Numbers
hl('@boolean.yaml', { fg = properties.booleans }) -- true/false
hl('@constant.builtin.yaml', { fg = properties.constants }) -- null
hl('@punctuation.delimiter.yaml', { fg = properties.punctuation }) -- Colons, commas
hl('@punctuation.special.yaml', { fg = properties.special_punctuation }) -- Note: changed from coral to orange for consistency
hl('@operator.yaml', { fg = properties.operators }) -- YAML operators like |, >
hl('@type.yaml', { fg = properties.types }) -- Types and tags
hl('@tag.yaml', { fg = properties.tags }) -- YAML tags like !!str
hl('@label.yaml', { fg = properties.labels }) -- Anchors and aliases

-- Enhanced Tree-sitter highlights for JSON
hl('@field.json', { fg = properties.fields }) -- Object keys
hl('@property.json', { fg = properties.properties }) -- Alternative for keys
hl('@string.json', { fg = properties.strings }) -- String values
hl('@number.json', { fg = properties.numbers }) -- Numbers
hl('@boolean.json', { fg = properties.booleans }) -- true/false
hl('@constant.builtin.json', { fg = properties.constants }) -- null
hl('@punctuation.bracket.json', { fg = properties.punctuation }) -- Brackets and braces
hl('@punctuation.delimiter.json', { fg = properties.punctuation }) -- Colons and commas

-- TOML support (bonus)
hl('@field.toml', { fg = properties.fields })
hl('@property.toml', { fg = properties.properties })
hl('@string.toml', { fg = properties.strings })
hl('@number.toml', { fg = properties.numbers })
hl('@boolean.toml', { fg = properties.booleans })
hl('@constant.builtin.toml', { fg = properties.constants })
hl('@type.toml', { fg = properties.types }) -- Section headers
hl('@punctuation.delimiter.toml', { fg = properties.punctuation })
hl('@punctuation.bracket.toml', { fg = properties.punctuation })

-- XML/HTML improvements
hl('@tag.xml', { fg = properties.tags })
hl('@tag.html', { fg = properties.tags })
hl('@tag.attribute.xml', { fg = properties.attributes })
hl('@tag.attribute.html', { fg = properties.attributes })
hl('@string.xml', { fg = properties.strings })
hl('@string.html', { fg = properties.strings })

-- Markdown improvements
hl('@markup.heading.1.markdown', { fg = properties.markup_headings, bold = true })
hl('@markup.heading.2.markdown', { fg = properties.markup_headings, bold = true })
hl('@markup.heading.3.markdown', { fg = properties.markup_headings, bold = true })
hl('@markup.heading.4.markdown', { fg = properties.markup_headings, bold = true })
hl('@markup.heading.5.markdown', { fg = properties.markup_headings, bold = true })
hl('@markup.heading.6.markdown', { fg = properties.markup_headings, bold = true })
hl('@markup.list.markdown', { fg = properties.markup_emphasis }) -- List markers
hl('@markup.link.markdown', { fg = properties.markup_links, underline = true })
hl('@markup.raw.markdown', { fg = properties.markup_code }) -- Code blocks
hl('@markup.raw.inline.markdown', { fg = properties.markup_code }) -- Inline code
hl('@markup.quote.markdown', { fg = properties.markup_emphasis, italic = true })
hl('@markup.strong.markdown', { fg = properties.markup_emphasis, bold = true })
hl('@markup.italic.markdown', { fg = properties.markup_emphasis, italic = true })

-- COMPREHENSIVE DOCKER/CONTAINERFILE IMPROVEMENTS
-- Tree-sitter highlights for Docker files
hl('@keyword.dockerfile', { fg = properties.keywords, bold = true }) -- FROM, RUN, COPY, ADD, etc.
hl('@keyword.instruction.dockerfile', { fg = properties.keywords, bold = true }) -- All Dockerfile instructions
hl('@string.dockerfile', { fg = properties.strings }) -- Quoted strings
hl('@string.plain.dockerfile', { fg = properties.strings }) -- Unquoted strings
hl('@string.quoted.dockerfile', { fg = properties.strings }) -- Explicitly quoted strings
hl('@variable.dockerfile', { fg = properties.variables }) -- Environment variables like $VAR, ${VAR}
hl('@variable.builtin.dockerfile', { fg = properties.variables }) -- Built-in variables
hl('@variable.parameter.dockerfile', { fg = properties.variables }) -- Parameter variables
hl('@constant.dockerfile', { fg = properties.constants }) -- Constants and literal values
hl('@number.dockerfile', { fg = properties.numbers }) -- Port numbers, version numbers
hl('@operator.dockerfile', { fg = properties.operators }) -- Operators like =, :
hl('@punctuation.dockerfile', { fg = properties.punctuation }) -- General punctuation
hl('@punctuation.delimiter.dockerfile', { fg = properties.punctuation }) -- Delimiters like commas
hl('@punctuation.bracket.dockerfile', { fg = properties.punctuation }) -- Brackets and braces
hl('@punctuation.special.dockerfile', { fg = properties.special_punctuation })
hl('@comment.dockerfile', { fg = properties.comments, italic = true }) -- Comments
hl('@function.dockerfile', { fg = properties.functions }) -- Function-like constructs
hl('@parameter.dockerfile', { fg = properties.variables }) -- Parameters in instructions
hl('@field.dockerfile', { fg = properties.fields }) -- Field names in key=value pairs
hl('@property.dockerfile', { fg = properties.properties }) -- Properties
hl('@label.dockerfile', { fg = properties.labels }) -- Labels and metadata
hl('@flag.dockerfile', { fg = properties.flags }) -- Command flags like --from, --chown
hl('@option.dockerfile', { fg = properties.flags }) -- Options and flags
hl('@path.dockerfile', { fg = properties.paths }) -- File paths
hl('@url.dockerfile', { fg = properties.urls, underline = true }) -- URLs
hl('@tag.dockerfile', { fg = properties.tags }) -- Image tags
hl('@namespace.dockerfile', { fg = properties.namespaces }) -- Namespaces and registries

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
hl('@field.docker-compose', { fg = properties.fields }) -- Service names, keys
hl('@string.docker-compose', { fg = properties.strings }) -- String values
hl('@number.docker-compose', { fg = properties.numbers }) -- Port numbers, versions
hl('@boolean.docker-compose', { fg = properties.booleans }) -- true/false
hl('dockerComposeKeyword', { fg = colors.coral }) -- version, services, etc.
hl('dockerComposeString', { fg = colors.green }) -- Quoted strings
hl('dockerComposeComment', { fg = colors.fg_dark, italic = true }) -- Comments
hl('dockerComposePort', { fg = colors.red }) -- Port mappings
hl('dockerComposeVolume', { fg = colors.blue }) -- Volume definitions
hl('dockerComposeEnvironment', { fg = colors.cyan }) -- Environment variables

-- Shell script improvements
hl('@keyword.bash', { fg = properties.keywords })
hl('@function.bash', { fg = properties.functions })
hl('@variable.bash', { fg = properties.variables })
hl('@string.bash', { fg = properties.strings })
hl('@punctuation.special.bash', { fg = properties.special_punctuation })

-- CSS improvements
hl('@property.css', { fg = properties.properties }) -- CSS properties
hl('@string.css', { fg = properties.strings }) -- String values
hl('@number.css', { fg = properties.numbers }) -- Numbers and units
hl('@type.css', { fg = properties.types }) -- CSS selectors
hl('@function.css', { fg = properties.functions }) -- CSS functions like rgb()
hl('@punctuation.delimiter.css', { fg = properties.punctuation })

-- JavaScript/TypeScript improvements
hl('@constructor.javascript', { fg = properties.constructors })
hl('@constructor.typescript', { fg = properties.constructors })
hl('@variable.member.javascript', { fg = properties.variables })
hl('@variable.member.typescript', { fg = properties.variables })
hl('@keyword.import.javascript', { fg = properties.keywords })
hl('@keyword.import.typescript', { fg = properties.keywords })
hl('@keyword.export.javascript', { fg = properties.keywords })
hl('@keyword.export.typescript', { fg = properties.keywords })

-- Python improvements
hl('@keyword.import.python', { fg = properties.keywords })
hl('@constructor.python', { fg = properties.constructors })
hl('@variable.member.python', { fg = properties.variables })
hl('@function.builtin.python', { fg = properties.functions })
hl('@constant.builtin.python', { fg = properties.constants }) -- True, False, None

-- Go improvements
hl('@keyword.go', { fg = properties.keywords }) -- func, var, const, etc.
hl('@keyword.import.go', { fg = properties.keywords }) -- import
hl('@type.builtin.go', { fg = properties.types }) -- int, string, bool, etc.
hl('@function.go', { fg = properties.functions }) -- Function names
hl('@variable.go', { fg = properties.variables }) -- Variables
hl('@constant.go', { fg = properties.constants }) -- Constants
hl('@string.go', { fg = properties.strings }) -- Strings
hl('@operator.go', { fg = properties.operators }) -- Operators
hl('@punctuation.delimiter.go', { fg = properties.punctuation }) -- Commas, semicolons

-- Rust improvements
hl('@keyword.rust', { fg = properties.keywords }) -- fn, let, mut, etc.
hl('@keyword.import.rust', { fg = properties.keywords }) -- use
hl('@type.rust', { fg = properties.types }) -- Custom types
hl('@type.builtin.rust', { fg = properties.types }) -- i32, u64, String, etc.
hl('@function.rust', { fg = properties.functions }) -- Function names
hl('@variable.rust', { fg = properties.variables }) -- Variables
hl('@constant.rust', { fg = properties.constants }) -- Constants
hl('@string.rust', { fg = properties.strings }) -- Strings
hl('@attribute.rust', { fg = properties.annotations }) -- #[derive], #[cfg], etc.
hl('@punctuation.delimiter.rust', { fg = properties.punctuation }) -- Commas, semicolons
hl('@operator.rust', { fg = properties.operators }) -- Operators

-- Java improvements
hl('@keyword.java', { fg = properties.keywords }) -- class, public, private, etc.
hl('@keyword.import.java', { fg = properties.keywords }) -- import
hl('@type.java', { fg = properties.types }) -- Class names
hl('@type.builtin.java', { fg = properties.types }) -- int, String, boolean, etc.
hl('@function.java', { fg = properties.functions }) -- Method names
hl('@variable.java', { fg = properties.variables }) -- Variables
hl('@constant.java', { fg = properties.constants }) -- Constants
hl('@string.java', { fg = properties.strings }) -- Strings
hl('@annotation.java', { fg = properties.annotations }) -- @Override, @Deprecated, etc.
hl('@punctuation.delimiter.java', { fg = properties.punctuation }) -- Commas, semicolons

-- C improvements
hl('@keyword.c', { fg = properties.keywords }) -- int, char, if, for, etc.
hl('@keyword.import.c', { fg = properties.keywords }) -- #include
hl('@type.c', { fg = properties.types }) -- Custom types
hl('@type.builtin.c', { fg = properties.types }) -- int, char, float, etc.
hl('@function.c', { fg = properties.functions }) -- Function names
hl('@variable.c', { fg = properties.variables }) -- Variables
hl('@constant.c', { fg = properties.constants }) -- Constants
hl('@string.c', { fg = properties.strings }) -- Strings
hl('@preproc.c', { fg = properties.preprocessor }) -- Preprocessor directives
hl('@punctuation.delimiter.c', { fg = properties.punctuation }) -- Commas, semicolons

-- C++ improvements
hl('@keyword.cpp', { fg = properties.keywords }) -- class, namespace, template, etc.
hl('@keyword.import.cpp', { fg = properties.keywords }) -- #include, using
hl('@type.cpp', { fg = properties.types }) -- Custom types
hl('@type.builtin.cpp', { fg = properties.types }) -- int, std::string, etc.
hl('@function.cpp', { fg = properties.functions }) -- Function names
hl('@variable.cpp', { fg = properties.variables }) -- Variables
hl('@constant.cpp', { fg = properties.constants }) -- Constants
hl('@string.cpp', { fg = properties.strings }) -- Strings
hl('@namespace.cpp', { fg = properties.namespaces }) -- std, etc.
hl('@preproc.cpp', { fg = properties.preprocessor }) -- Preprocessor directives
hl('@punctuation.delimiter.cpp', { fg = properties.punctuation }) -- Commas, semicolons

-- C# improvements
hl('@keyword.cs', { fg = properties.keywords }) -- class, using, namespace, etc.
hl('@keyword.import.cs', { fg = properties.keywords }) -- using
hl('@type.cs', { fg = properties.types }) -- Custom types
hl('@type.builtin.cs', { fg = properties.types }) -- int, string, bool, etc.
hl('@function.cs', { fg = properties.functions }) -- Method names
hl('@variable.cs', { fg = properties.variables }) -- Variables
hl('@constant.cs', { fg = properties.constants }) -- Constants
hl('@string.cs', { fg = properties.strings }) -- Strings
hl('@attribute.cs', { fg = properties.annotations }) -- [Attribute]
hl('@punctuation.delimiter.cs', { fg = properties.punctuation }) -- Commas, semicolons

-- PHP improvements
hl('@keyword.php', { fg = properties.keywords }) -- class, function, if, etc.
hl('@keyword.import.php', { fg = properties.keywords }) -- use, require, include
hl('@type.php', { fg = properties.types }) -- Custom types
hl('@function.php', { fg = properties.functions }) -- Function names
hl('@variable.php', { fg = properties.variables }) -- Variables (including $)
hl('@constant.php', { fg = properties.constants }) -- Constants
hl('@string.php', { fg = properties.strings }) -- Strings
hl('@variable.builtin.php', { fg = properties.variables }) -- $this, $_GET, etc.
hl('@punctuation.delimiter.php', { fg = properties.punctuation }) -- Commas, semicolons

-- Ruby improvements
hl('@keyword.ruby', { fg = properties.keywords }) -- def, class, if, etc.
hl('@keyword.import.ruby', { fg = properties.keywords }) -- require, include
hl('@type.ruby', { fg = properties.types }) -- Class names
hl('@function.ruby', { fg = properties.functions }) -- Method names
hl('@variable.ruby', { fg = properties.variables }) -- Variables
hl('@constant.ruby', { fg = properties.constants }) -- Constants
hl('@string.ruby', { fg = properties.strings }) -- Strings
hl('@symbol.ruby', { fg = properties.symbols }) -- :symbol
hl('@variable.builtin.ruby', { fg = properties.variables }) -- self, super
hl('@punctuation.delimiter.ruby', { fg = properties.punctuation }) -- Commas, etc.

-- Swift improvements
hl('@keyword.swift', { fg = properties.keywords }) -- func, class, var, let, etc.
hl('@keyword.import.swift', { fg = properties.keywords }) -- import
hl('@type.swift', { fg = properties.types }) -- Custom types
hl('@type.builtin.swift', { fg = properties.types }) -- Int, String, Bool, etc.
hl('@function.swift', { fg = properties.functions }) -- Function names
hl('@variable.swift', { fg = properties.variables }) -- Variables
hl('@constant.swift', { fg = properties.constants }) -- Constants
hl('@string.swift', { fg = properties.strings }) -- Strings
hl('@attribute.swift', { fg = properties.annotations }) -- @objc, @available, etc.
hl('@punctuation.delimiter.swift', { fg = properties.punctuation }) -- Commas, semicolons

-- Kotlin improvements
hl('@keyword.kotlin', { fg = properties.keywords }) -- fun, class, val, var, etc.
hl('@keyword.import.kotlin', { fg = properties.keywords }) -- import
hl('@type.kotlin', { fg = properties.types }) -- Custom types
hl('@type.builtin.kotlin', { fg = properties.types }) -- Int, String, Boolean, etc.
hl('@function.kotlin', { fg = properties.functions }) -- Function names
hl('@variable.kotlin', { fg = properties.variables }) -- Variables
hl('@constant.kotlin', { fg = properties.constants }) -- Constants
hl('@string.kotlin', { fg = properties.strings }) -- Strings
hl('@annotation.kotlin', { fg = properties.annotations }) -- @JvmStatic, etc.
hl('@punctuation.delimiter.kotlin', { fg = properties.punctuation }) -- Commas, semicolons

-- Dart improvements
hl('@keyword.dart', { fg = properties.keywords }) -- class, void, if, etc.
hl('@keyword.import.dart', { fg = properties.keywords }) -- import
hl('@type.dart', { fg = properties.types }) -- Custom types
hl('@type.builtin.dart', { fg = properties.types }) -- int, String, bool, etc.
hl('@function.dart', { fg = properties.functions }) -- Function names
hl('@variable.dart', { fg = properties.variables }) -- Variables
hl('@constant.dart', { fg = properties.constants }) -- Constants
hl('@string.dart', { fg = properties.strings }) -- Strings
hl('@annotation.dart', { fg = properties.annotations }) -- @override, etc.
hl('@punctuation.delimiter.dart', { fg = properties.punctuation }) -- Commas, semicolons

-- SQL improvements
hl('@keyword.sql', { fg = properties.keywords }) -- SELECT, FROM, WHERE, etc.
hl('@type.sql', { fg = properties.types }) -- VARCHAR, INT, etc.
hl('@function.sql', { fg = properties.functions }) -- COUNT, SUM, etc.
hl('@string.sql', { fg = properties.strings }) -- String literals
hl('@number.sql', { fg = properties.numbers }) -- Numbers
hl('@operator.sql', { fg = properties.operators }) -- =, <, >, etc.
hl('@punctuation.delimiter.sql', { fg = properties.punctuation }) -- Commas, semicolons

-- Lua improvements (bonus for Neovim users)
hl('@keyword.lua', { fg = properties.keywords }) -- function, local, if, etc.
hl('@function.lua', { fg = properties.functions }) -- Function names
hl('@variable.lua', { fg = properties.variables }) -- Variables
hl('@constant.lua', { fg = properties.constants }) -- Constants
hl('@string.lua', { fg = properties.strings }) -- Strings
hl('@function.builtin.lua', { fg = properties.functions }) -- print, pairs, etc.
hl('@constant.builtin.lua', { fg = properties.constants }) -- nil, true, false
hl('@punctuation.delimiter.lua', { fg = properties.punctuation }) -- Commas, semicolons

-- Vim script improvements (bonus for Vim users)
hl('@keyword.vim', { fg = properties.keywords }) -- function, let, if, etc.
hl('@function.vim', { fg = properties.functions }) -- Function names
hl('@variable.vim', { fg = properties.variables }) -- Variables
hl('@constant.vim', { fg = properties.constants }) -- Constants
hl('@string.vim', { fg = properties.strings }) -- Strings
hl('@function.builtin.vim', { fg = properties.functions }) -- Built-in functions
hl('@punctuation.delimiter.vim', { fg = properties.punctuation }) -- Commas, etc.

-- RPM spec file improvements
hl('@keyword.spec', { fg = properties.keywords }) -- Section headers like %prep, %build, %install
hl('@function.spec', { fg = properties.functions }) -- RPM macros like %{name}, %{version}
hl('@variable.spec', { fg = properties.variables }) -- Variables and substitutions
hl('@constant.spec', { fg = properties.constants }) -- Version numbers, release numbers
hl('@string.spec', { fg = properties.strings }) -- Quoted strings and descriptions
hl('@comment.spec', { fg = properties.comments, italic = true }) -- Comments
hl('@type.spec', { fg = properties.types }) -- Package names, dependencies
hl('@operator.spec', { fg = properties.operators }) -- Operators like >=, <=, =
hl('@punctuation.spec', { fg = properties.punctuation }) -- General punctuation
hl('@punctuation.delimiter.spec', { fg = properties.punctuation }) -- Colons, commas
hl('@tag.spec', { fg = properties.tags }) -- Tags like Name:, Version:, Summary:
hl('@attribute.spec', { fg = properties.annotations }) -- Attributes and flags
hl('@number.spec', { fg = properties.numbers }) -- Numbers in versions, etc.

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
