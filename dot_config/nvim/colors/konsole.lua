-- konsole.lua — custom colorscheme for KDE Konsole (#232627 background)

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "konsole"
vim.o.background = "dark"

-- stylua: ignore start
local p = {
    -- Base
    bg        = '#232627',
    bg_dark   = '#1b1e1f',
    bg_float  = '#1e2122',
    bg_line   = '#2a2e30',
    bg_visual = '#314559',
    bg_search = '#4a5e3a',
    bg_popup  = '#2c3133',

    -- Foreground
    fg        = '#d3d7cf',
    fg_bright = '#eff0eb',
    fg_dim    = '#6b7d70',
    fg_dark   = '#4a5550',

    -- Syntax
    blue      = '#5b9bf5',
    cyan      = '#56d4c4',
    green     = '#87d65a',
    yellow    = '#efc050',
    orange    = '#e8875c',
    red       = '#ed5a5a',
    magenta   = '#c77dbb',
    teal      = '#4db8a4',
    peach     = '#d4a37c',
    pink      = '#cf8e9e',

    -- UI
    border    = '#3e4548',
    cursorln  = '#2a2e30',
    match     = '#5b9bf5',
    added     = '#5e9e5e',
    changed   = '#d4a055',
    removed   = '#c75050',
    error     = '#ed5a5a',
    warn      = '#efc050',
    info      = '#5b9bf5',
    hint      = '#4db8a4',
}
-- stylua: ignore end

local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end


-- ┌──────────────────────────────────────────────┐
-- │  Editor UI                                    │
-- └──────────────────────────────────────────────┘

hi("Normal",       { fg = p.fg, bg = p.bg })
hi("NormalFloat",  { fg = p.fg, bg = p.bg_float })
hi("FloatBorder",  { fg = p.border, bg = p.bg_float })
hi("FloatTitle",   { fg = p.yellow, bg = p.bg_float, bold = true })
hi("Cursor",       { fg = p.bg, bg = p.fg })
hi("CursorLine",   { bg = p.cursorln })
hi("CursorLineNr", { fg = p.yellow, bold = true })
hi("LineNr",       { fg = p.fg_dark })
hi("SignColumn",   { bg = p.bg })
hi("ColorColumn",  { bg = p.bg_line })
hi("Visual",       { bg = p.bg_visual })
hi("VisualNOS",    { bg = p.bg_visual })
hi("Search",       { fg = p.fg_bright, bg = p.bg_search })
hi("IncSearch",    { fg = p.bg, bg = p.yellow, bold = true })
hi("CurSearch",    { fg = p.bg, bg = p.orange, bold = true })
hi("Substitute",   { fg = p.bg, bg = p.red })
hi("MatchParen",   { fg = p.yellow, bg = p.bg_visual, bold = true })
hi("Pmenu",        { fg = p.fg, bg = p.bg_popup })
hi("PmenuSel",     { fg = p.fg_bright, bg = p.bg_visual })
hi("PmenuSbar",    { bg = p.bg_popup })
hi("PmenuThumb",   { bg = p.border })
hi("WildMenu",     { fg = p.bg, bg = p.blue })
hi("StatusLine",   { fg = p.fg, bg = p.bg_line })
hi("StatusLineNC", { fg = p.fg_dim, bg = p.bg_dark })
hi("TabLine",      { fg = p.fg_dim, bg = p.bg_dark })
hi("TabLineFill",  { bg = p.bg_dark })
hi("TabLineSel",   { fg = p.fg_bright, bg = p.bg, bold = true })
hi("WinSeparator", { fg = p.border })
hi("VertSplit",    { fg = p.border })
hi("Folded",       { fg = p.fg_dim, bg = p.bg_line })
hi("FoldColumn",   { fg = p.fg_dark })
hi("NonText",      { fg = p.fg_dark })
hi("SpecialKey",   { fg = p.fg_dark })
hi("Whitespace",   { fg = p.fg_dark })
hi("EndOfBuffer",  { fg = p.bg })
hi("Directory",    { fg = p.blue })
hi("Title",        { fg = p.fg_bright, bold = true })
hi("ErrorMsg",     { fg = p.red, bold = true })
hi("WarningMsg",   { fg = p.warn })
hi("MoreMsg",      { fg = p.green })
hi("ModeMsg",      { fg = p.fg, bold = true })
hi("Question",     { fg = p.green })
hi("Conceal",      { fg = p.fg_dim })
hi("SpellBad",     { undercurl = true, sp = p.red })
hi("SpellCap",     { undercurl = true, sp = p.yellow })
hi("SpellLocal",   { undercurl = true, sp = p.cyan })
hi("SpellRare",    { undercurl = true, sp = p.magenta })
hi("DiffAdd",      { bg = '#2a3a2a' })
hi("DiffChange",   { bg = '#2a2e3a' })
hi("DiffDelete",   { fg = p.removed, bg = '#3a2a2a' })
hi("DiffText",     { bg = '#3a3e4a' })
hi("WinBar",       { fg = p.fg, bold = true })
hi("WinBarNC",     { fg = p.fg_dim })


-- ┌──────────────────────────────────────────────┐
-- │  Syntax (Vim legacy groups)                   │
-- └──────────────────────────────────────────────┘

hi("Comment",     { fg = p.fg_dim, italic = true })
hi("Constant",    { fg = p.orange })
hi("String",      { fg = p.cyan })
hi("Character",   { fg = p.cyan })
hi("Number",      { fg = p.orange })
hi("Boolean",     { fg = p.orange, bold = true })
hi("Float",       { fg = p.orange })
hi("Identifier",  { fg = p.fg })
hi("Function",    { fg = p.green, bold = true })
hi("Statement",   { fg = p.blue })
hi("Conditional", { fg = p.blue })
hi("Repeat",      { fg = p.blue })
hi("Label",       { fg = p.blue })
hi("Operator",    { fg = p.pink })
hi("Keyword",     { fg = p.blue, bold = true })
hi("Exception",   { fg = p.blue })
hi("PreProc",     { fg = p.magenta })
hi("Include",     { fg = p.magenta })
hi("Define",      { fg = p.magenta })
hi("Macro",       { fg = p.magenta })
hi("PreCondit",   { fg = p.magenta })
hi("Type",        { fg = p.yellow })
hi("StorageClass", { fg = p.yellow })
hi("Structure",   { fg = p.yellow })
hi("Typedef",     { fg = p.yellow })
hi("Special",     { fg = p.peach })
hi("SpecialChar", { fg = p.teal })
hi("Tag",         { fg = p.blue })
hi("Delimiter",   { fg = p.fg })
hi("Debug",       { fg = p.red })
hi("Underlined",  { underline = true })
hi("Bold",        { bold = true })
hi("Italic",      { italic = true })
hi("Ignore",      { fg = p.fg_dark })
hi("Error",       { fg = p.red, bold = true })
hi("Todo",        { fg = p.bg, bg = p.yellow, bold = true })


-- ┌──────────────────────────────────────────────┐
-- │  Treesitter                                   │
-- └──────────────────────────────────────────────┘

-- Identifiers
hi("@variable",             { fg = p.fg })
hi("@variable.builtin",     { fg = p.peach, italic = true })
hi("@variable.parameter",   { fg = p.peach })
hi("@variable.member",      { fg = p.teal })

hi("@constant",             { fg = p.orange })
hi("@constant.builtin",     { fg = p.orange, bold = true })
hi("@constant.macro",       { fg = p.orange })

hi("@module",               { fg = p.teal })
hi("@label",                { fg = p.blue })

-- Literals
hi("@string",               { fg = p.cyan })
hi("@string.documentation", { fg = p.cyan, italic = true })
hi("@string.escape",        { fg = p.teal, bold = true })
hi("@string.regex",         { fg = p.teal })
hi("@string.special",       { fg = p.teal })

hi("@character",            { fg = p.cyan })
hi("@character.special",    { fg = p.teal })

hi("@number",               { fg = p.orange })
hi("@number.float",         { fg = p.orange })
hi("@boolean",              { fg = p.orange, bold = true })

-- Types
hi("@type",                 { fg = p.yellow })
hi("@type.builtin",         { fg = p.yellow, italic = true })
hi("@type.definition",      { fg = p.yellow, bold = true })
hi("@type.qualifier",       { fg = p.blue })

hi("@attribute",            { fg = p.magenta })
hi("@property",             { fg = p.teal })

-- Functions
hi("@function",             { fg = p.green, bold = true })
hi("@function.builtin",     { fg = p.green })
hi("@function.call",        { fg = p.green })
hi("@function.macro",       { fg = p.magenta })
hi("@function.method",      { fg = p.green })
hi("@function.method.call", { fg = p.green })

hi("@constructor",          { fg = p.yellow })

-- Keywords
hi("@keyword",              { fg = p.blue, bold = true })
hi("@keyword.coroutine",    { fg = p.magenta, bold = true })
hi("@keyword.function",     { fg = p.blue, bold = true })
hi("@keyword.operator",     { fg = p.pink })
hi("@keyword.import",       { fg = p.magenta })
hi("@keyword.modifier",     { fg = p.blue })
hi("@keyword.repeat",       { fg = p.blue })
hi("@keyword.return",       { fg = p.blue, bold = true })
hi("@keyword.exception",    { fg = p.blue })
hi("@keyword.conditional",  { fg = p.blue })
hi("@keyword.directive",    { fg = p.magenta })

-- Punctuation
hi("@punctuation.bracket",   { fg = p.fg_dim })
hi("@punctuation.delimiter", { fg = p.fg_dim })
hi("@punctuation.special",   { fg = p.pink })

-- Comments
hi("@comment",              { fg = p.fg_dim, italic = true })
hi("@comment.documentation",{ fg = p.fg_dim, italic = true })
hi("@comment.error",        { fg = p.red, bg = '#3a2a2a', bold = true })
hi("@comment.warning",      { fg = p.yellow, bg = '#3a3520', bold = true })
hi("@comment.todo",         { fg = p.bg, bg = p.yellow, bold = true })
hi("@comment.note",         { fg = p.bg, bg = p.info, bold = true })

-- Markup
hi("@markup.strong",        { bold = true })
hi("@markup.italic",        { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.underline",     { underline = true })
hi("@markup.heading",       { fg = p.fg_bright, bold = true })
hi("@markup.raw",           { fg = p.cyan })
hi("@markup.link",          { fg = p.blue, underline = true })
hi("@markup.link.url",      { fg = p.cyan, underline = true })
hi("@markup.link.label",    { fg = p.blue })
hi("@markup.list",          { fg = p.pink })
hi("@markup.math",          { fg = p.magenta })

-- Misc treesitter
hi("@operator",             { fg = p.pink })
hi("@scope",                { fg = p.fg })
hi("@none",                 {})

-- Tags (HTML/JSX)
hi("@tag",                  { fg = p.blue })
hi("@tag.attribute",        { fg = p.peach })
hi("@tag.delimiter",        { fg = p.fg_dim })


-- ┌──────────────────────────────────────────────┐
-- │  LSP Semantic Tokens                          │
-- └──────────────────────────────────────────────┘

hi("@lsp.type.class",         { link = "@type" })
hi("@lsp.type.decorator",     { link = "@attribute" })
hi("@lsp.type.enum",          { link = "@type" })
hi("@lsp.type.enumMember",    { link = "@constant" })
hi("@lsp.type.function",      { link = "@function" })
hi("@lsp.type.interface",     { link = "@type" })
hi("@lsp.type.keyword",       { link = "@keyword" })
hi("@lsp.type.macro",         { link = "@function.macro" })
hi("@lsp.type.method",        { link = "@function.method" })
hi("@lsp.type.namespace",     { link = "@module" })
hi("@lsp.type.parameter",     { link = "@variable.parameter" })
hi("@lsp.type.property",      { link = "@property" })
hi("@lsp.type.struct",        { link = "@type" })
hi("@lsp.type.type",          { link = "@type" })
hi("@lsp.type.typeParameter", { link = "@type" })
hi("@lsp.type.variable",      { link = "@variable" })
hi("@lsp.mod.defaultLibrary", { italic = true })


-- ┌──────────────────────────────────────────────┐
-- │  Diagnostics                                  │
-- └──────────────────────────────────────────────┘

hi("DiagnosticError",          { fg = p.error })
hi("DiagnosticWarn",           { fg = p.warn })
hi("DiagnosticInfo",           { fg = p.info })
hi("DiagnosticHint",           { fg = p.hint })
hi("DiagnosticOk",             { fg = p.added })
hi("DiagnosticUnderlineError", { undercurl = true, sp = p.error })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.warn })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.info })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = p.hint })
hi("DiagnosticVirtualTextError", { fg = p.error, bg = '#3a2525' })
hi("DiagnosticVirtualTextWarn",  { fg = p.warn, bg = '#3a3520' })
hi("DiagnosticVirtualTextInfo",  { fg = p.info, bg = '#252e3a' })
hi("DiagnosticVirtualTextHint",  { fg = p.hint, bg = '#253530' })


-- ┌──────────────────────────────────────────────┐
-- │  LSP UI                                       │
-- └──────────────────────────────────────────────┘

hi("LspReferenceText",  { bg = p.bg_line })
hi("LspReferenceRead",  { bg = p.bg_line })
hi("LspReferenceWrite", { bg = p.bg_visual })
hi("LspSignatureActiveParameter", { fg = p.yellow, bold = true, underline = true })
hi("LspInlayHint",      { fg = p.fg_dark, bg = p.bg_line, italic = true })


-- ┌──────────────────────────────────────────────┐
-- │  Plugins                                      │
-- └──────────────────────────────────────────────┘

-- Telescope
hi("TelescopeNormal",       { fg = p.fg, bg = p.bg_float })
hi("TelescopeBorder",       { fg = p.border, bg = p.bg_float })
hi("TelescopeTitle",        { fg = p.yellow, bold = true })
hi("TelescopePromptNormal", { fg = p.fg, bg = p.bg_line })
hi("TelescopePromptBorder", { fg = p.border, bg = p.bg_line })
hi("TelescopePromptTitle",  { fg = p.bg, bg = p.green, bold = true })
hi("TelescopePromptPrefix", { fg = p.green })
hi("TelescopePreviewTitle", { fg = p.bg, bg = p.blue, bold = true })
hi("TelescopeResultsTitle", { fg = p.bg, bg = p.magenta, bold = true })
hi("TelescopeSelection",    { bg = p.bg_visual })
hi("TelescopeMatching",     { fg = p.yellow, bold = true })

-- nvim-cmp
hi("CmpItemAbbr",           { fg = p.fg })
hi("CmpItemAbbrDeprecated", { fg = p.fg_dark, strikethrough = true })
hi("CmpItemAbbrMatch",      { fg = p.yellow, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = p.yellow })
hi("CmpItemKindFunction",   { fg = p.green })
hi("CmpItemKindMethod",     { fg = p.green })
hi("CmpItemKindVariable",   { fg = p.fg })
hi("CmpItemKindField",      { fg = p.teal })
hi("CmpItemKindProperty",   { fg = p.teal })
hi("CmpItemKindClass",      { fg = p.yellow })
hi("CmpItemKindInterface",  { fg = p.yellow })
hi("CmpItemKindStruct",     { fg = p.yellow })
hi("CmpItemKindModule",     { fg = p.teal })
hi("CmpItemKindKeyword",    { fg = p.blue })
hi("CmpItemKindText",       { fg = p.fg })
hi("CmpItemKindSnippet",    { fg = p.magenta })
hi("CmpItemKindConstant",   { fg = p.orange })
hi("CmpItemKindValue",      { fg = p.orange })
hi("CmpItemKindEnum",       { fg = p.yellow })
hi("CmpItemKindEnumMember", { fg = p.orange })
hi("CmpItemKindOperator",   { fg = p.pink })
hi("CmpItemKindReference",  { fg = p.peach })
hi("CmpItemKindTypeParameter", { fg = p.yellow })
hi("CmpItemMenu",           { fg = p.fg_dim })

-- GitSigns
hi("GitSignsAdd",          { fg = p.added })
hi("GitSignsChange",       { fg = p.changed })
hi("GitSignsDelete",       { fg = p.removed })
hi("GitSignsAddNr",        { fg = p.added })
hi("GitSignsChangeNr",     { fg = p.changed })
hi("GitSignsDeleteNr",     { fg = p.removed })
hi("GitSignsAddLn",        { bg = '#2a3a2a' })
hi("GitSignsChangeLn",     { bg = '#2a2e3a' })
hi("GitSignsDeleteLn",     { bg = '#3a2a2a' })

-- DAP
hi("DapBreakpoint",        { fg = p.red })
hi("DapStopped",           { fg = p.yellow })
hi("DapLogPoint",          { fg = p.blue })
hi("DapBreakpointCondition", { fg = p.orange })

-- Todo Comments
hi("TodoBgFIX",  { fg = p.bg, bg = p.red, bold = true })
hi("TodoBgHACK", { fg = p.bg, bg = p.orange, bold = true })
hi("TodoBgTODO", { fg = p.bg, bg = p.yellow, bold = true })
hi("TodoBgNOTE", { fg = p.bg, bg = p.hint, bold = true })
hi("TodoBgWARN", { fg = p.bg, bg = p.warn, bold = true })
hi("TodoBgPERF", { fg = p.bg, bg = p.magenta, bold = true })
hi("TodoBgTEST", { fg = p.bg, bg = p.blue, bold = true })
hi("TodoFgFIX",  { fg = p.red })
hi("TodoFgHACK", { fg = p.orange })
hi("TodoFgTODO", { fg = p.yellow })
hi("TodoFgNOTE", { fg = p.hint })
hi("TodoFgWARN", { fg = p.warn })
hi("TodoFgPERF", { fg = p.magenta })
hi("TodoFgTEST", { fg = p.blue })

-- Oil
hi("OilDir",     { fg = p.blue, bold = true })
hi("OilLink",    { fg = p.cyan })
hi("OilFile",    { fg = p.fg })

-- Markdown (render-markdown.nvim)
hi("RenderMarkdownH1Bg", { bg = '#2e3545', bold = true })
hi("RenderMarkdownH2Bg", { bg = '#2e3840', bold = true })
hi("RenderMarkdownH3Bg", { bg = '#2e3535', bold = true })
hi("RenderMarkdownH4Bg", { bg = '#352e40', bold = true })
hi("RenderMarkdownH5Bg", { bg = '#35302e', bold = true })
hi("RenderMarkdownH6Bg", { bg = '#2e3530', bold = true })
hi("RenderMarkdownCode", { bg = p.bg_line })
