-- konsole.lua — custom colorscheme for KDE Konsole (#232627 background)
-- Syntax palette inspired by Monokai

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "konsole"
vim.o.background = "dark"

-- stylua: ignore start
local p = {
    -- Base (Konsole terminal)
    bg        = '#232627',
    bg_dark   = '#1b1e1f',
    bg_float  = '#1e2122',
    bg_line   = '#2a2e30',
    bg_visual = '#3e3d32',
    bg_search = '#4a5e3a',
    bg_popup  = '#2c3133',

    -- Foreground (Monokai)
    fg        = '#f8f8f2',
    fg_bright = '#ffffff',
    fg_dim    = '#75715e',
    fg_dark   = '#49483e',

    -- Syntax (Monokai)
    pink      = '#f92672',
    green     = '#a6e22e',
    yellow    = '#e6db74',
    orange    = '#fd971f',
    purple    = '#ae81ff',
    cyan      = '#66d9ef',

    -- UI
    border    = '#3e4548',
    cursorln  = '#2a2e30',
    match     = '#e6db74',
    added     = '#a6e22e',
    changed   = '#fd971f',
    removed   = '#f92672',
    error     = '#f92672',
    warn      = '#fd971f',
    info      = '#66d9ef',
    hint      = '#a6e22e',
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
hi("Substitute",   { fg = p.bg, bg = p.pink })
hi("MatchParen",   { fg = p.yellow, bg = p.bg_visual, bold = true })
hi("Pmenu",        { fg = p.fg, bg = p.bg_popup })
hi("PmenuSel",     { fg = p.fg_bright, bg = p.bg_visual })
hi("PmenuSbar",    { bg = p.bg_popup })
hi("PmenuThumb",   { bg = p.border })
hi("WildMenu",     { fg = p.bg, bg = p.cyan })
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
hi("Directory",    { fg = p.cyan })
hi("Title",        { fg = p.fg_bright, bold = true })
hi("ErrorMsg",     { fg = p.pink, bold = true })
hi("WarningMsg",   { fg = p.warn })
hi("MoreMsg",      { fg = p.green })
hi("ModeMsg",      { fg = p.fg, bold = true })
hi("Question",     { fg = p.green })
hi("Conceal",      { fg = p.fg_dim })
hi("SpellBad",     { undercurl = true, sp = p.pink })
hi("SpellCap",     { undercurl = true, sp = p.yellow })
hi("SpellLocal",   { undercurl = true, sp = p.cyan })
hi("SpellRare",    { undercurl = true, sp = p.purple })
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
hi("Constant",    { fg = p.purple })
hi("String",      { fg = p.yellow })
hi("Character",   { fg = p.yellow })
hi("Number",      { fg = p.purple })
hi("Boolean",     { fg = p.purple })
hi("Float",       { fg = p.purple })
hi("Identifier",  { fg = p.fg })
hi("Function",    { fg = p.green })
hi("Statement",   { fg = p.pink })
hi("Conditional", { fg = p.pink })
hi("Repeat",      { fg = p.pink })
hi("Label",       { fg = p.pink })
hi("Operator",    { fg = p.pink })
hi("Keyword",     { fg = p.pink })
hi("Exception",   { fg = p.pink })
hi("PreProc",     { fg = p.pink })
hi("Include",     { fg = p.pink })
hi("Define",      { fg = p.pink })
hi("Macro",       { fg = p.green })
hi("PreCondit",   { fg = p.pink })
hi("Type",        { fg = p.cyan, italic = true })
hi("StorageClass", { fg = p.pink })
hi("Structure",   { fg = p.cyan })
hi("Typedef",     { fg = p.cyan })
hi("Special",     { fg = p.orange })
hi("SpecialChar", { fg = p.purple })
hi("Tag",         { fg = p.pink })
hi("Delimiter",   { fg = p.fg })
hi("Debug",       { fg = p.pink })
hi("Underlined",  { underline = true })
hi("Bold",        { bold = true })
hi("Italic",      { italic = true })
hi("Ignore",      { fg = p.fg_dark })
hi("Error",       { fg = p.pink, bold = true })
hi("Todo",        { fg = p.bg, bg = p.yellow, bold = true })


-- ┌──────────────────────────────────────────────┐
-- │  Treesitter                                   │
-- └──────────────────────────────────────────────┘

-- Identifiers
hi("@variable",             { fg = p.fg })
hi("@variable.builtin",     { fg = p.orange, italic = true })
hi("@variable.parameter",   { fg = p.orange, italic = true })
hi("@variable.member",      { fg = p.fg })

hi("@constant",             { fg = p.purple })
hi("@constant.builtin",     { fg = p.purple, italic = true })
hi("@constant.macro",       { fg = p.purple })

hi("@module",               { fg = p.cyan, italic = true })
hi("@label",                { fg = p.pink })

-- Literals
hi("@string",               { fg = p.yellow })
hi("@string.documentation", { fg = p.yellow, italic = true })
hi("@string.escape",        { fg = p.purple })
hi("@string.regex",         { fg = p.yellow })
hi("@string.special",       { fg = p.purple })

hi("@character",            { fg = p.yellow })
hi("@character.special",    { fg = p.purple })

hi("@number",               { fg = p.purple })
hi("@number.float",         { fg = p.purple })
hi("@boolean",              { fg = p.purple })

-- Types
hi("@type",                 { fg = p.cyan, italic = true })
hi("@type.builtin",         { fg = p.cyan, italic = true })
hi("@type.definition",      { fg = p.cyan })
hi("@type.qualifier",       { fg = p.pink })

hi("@attribute",            { fg = p.green })
hi("@property",             { fg = p.fg })

-- Functions
hi("@function",             { fg = p.green })
hi("@function.builtin",     { fg = p.cyan })
hi("@function.call",        { fg = p.green })
hi("@function.macro",       { fg = p.green })
hi("@function.method",      { fg = p.green })
hi("@function.method.call", { fg = p.green })

hi("@constructor",          { fg = p.green })

-- Keywords
hi("@keyword",              { fg = p.pink })
hi("@keyword.coroutine",    { fg = p.pink })
hi("@keyword.function",     { fg = p.pink })
hi("@keyword.operator",     { fg = p.pink })
hi("@keyword.import",       { fg = p.pink })
hi("@keyword.modifier",     { fg = p.pink })
hi("@keyword.repeat",       { fg = p.pink })
hi("@keyword.return",       { fg = p.pink })
hi("@keyword.exception",    { fg = p.pink })
hi("@keyword.conditional",  { fg = p.pink })
hi("@keyword.directive",    { fg = p.pink })

-- Punctuation
hi("@punctuation.bracket",   { fg = p.fg_dim })
hi("@punctuation.delimiter", { fg = p.fg_dim })
hi("@punctuation.special",   { fg = p.pink })

-- Comments
hi("@comment",              { fg = p.fg_dim, italic = true })
hi("@comment.documentation",{ fg = p.fg_dim, italic = true })
hi("@comment.error",        { fg = p.pink, bg = '#3a2530', bold = true })
hi("@comment.warning",      { fg = p.orange, bg = '#3a3020', bold = true })
hi("@comment.todo",         { fg = p.bg, bg = p.yellow, bold = true })
hi("@comment.note",         { fg = p.bg, bg = p.info, bold = true })

-- Markup
hi("@markup.strong",        { bold = true })
hi("@markup.italic",        { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.underline",     { underline = true })
hi("@markup.heading",       { fg = p.fg_bright, bold = true })
hi("@markup.raw",           { fg = p.yellow })
hi("@markup.link",          { fg = p.cyan, underline = true })
hi("@markup.link.url",      { fg = p.cyan, underline = true })
hi("@markup.link.label",    { fg = p.cyan })
hi("@markup.list",          { fg = p.pink })
hi("@markup.math",          { fg = p.purple })

-- Misc treesitter
hi("@operator",             { fg = p.pink })
hi("@scope",                { fg = p.fg })
hi("@none",                 {})

-- Tags (HTML/JSX)
hi("@tag",                  { fg = p.pink })
hi("@tag.attribute",        { fg = p.green })
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
hi("DiagnosticVirtualTextError", { fg = p.error, bg = '#3a2530' })
hi("DiagnosticVirtualTextWarn",  { fg = p.warn, bg = '#3a3020' })
hi("DiagnosticVirtualTextInfo",  { fg = p.info, bg = '#253540' })
hi("DiagnosticVirtualTextHint",  { fg = p.hint, bg = '#2a3525' })


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
hi("TelescopePreviewTitle", { fg = p.bg, bg = p.cyan, bold = true })
hi("TelescopeResultsTitle", { fg = p.bg, bg = p.purple, bold = true })
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
hi("CmpItemKindField",      { fg = p.cyan })
hi("CmpItemKindProperty",   { fg = p.cyan })
hi("CmpItemKindClass",      { fg = p.cyan })
hi("CmpItemKindInterface",  { fg = p.cyan })
hi("CmpItemKindStruct",     { fg = p.cyan })
hi("CmpItemKindModule",     { fg = p.cyan })
hi("CmpItemKindKeyword",    { fg = p.pink })
hi("CmpItemKindText",       { fg = p.fg })
hi("CmpItemKindSnippet",    { fg = p.purple })
hi("CmpItemKindConstant",   { fg = p.purple })
hi("CmpItemKindValue",      { fg = p.purple })
hi("CmpItemKindEnum",       { fg = p.cyan })
hi("CmpItemKindEnumMember", { fg = p.purple })
hi("CmpItemKindOperator",   { fg = p.pink })
hi("CmpItemKindReference",  { fg = p.orange })
hi("CmpItemKindTypeParameter", { fg = p.cyan })
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
hi("DapBreakpoint",        { fg = p.pink })
hi("DapStopped",           { fg = p.yellow })
hi("DapLogPoint",          { fg = p.cyan })
hi("DapBreakpointCondition", { fg = p.orange })

-- Todo Comments
hi("TodoBgFIX",  { fg = p.bg, bg = p.pink, bold = true })
hi("TodoBgHACK", { fg = p.bg, bg = p.orange, bold = true })
hi("TodoBgTODO", { fg = p.bg, bg = p.yellow, bold = true })
hi("TodoBgNOTE", { fg = p.bg, bg = p.hint, bold = true })
hi("TodoBgWARN", { fg = p.bg, bg = p.warn, bold = true })
hi("TodoBgPERF", { fg = p.bg, bg = p.purple, bold = true })
hi("TodoBgTEST", { fg = p.bg, bg = p.cyan, bold = true })
hi("TodoFgFIX",  { fg = p.pink })
hi("TodoFgHACK", { fg = p.orange })
hi("TodoFgTODO", { fg = p.yellow })
hi("TodoFgNOTE", { fg = p.hint })
hi("TodoFgWARN", { fg = p.warn })
hi("TodoFgPERF", { fg = p.purple })
hi("TodoFgTEST", { fg = p.cyan })

-- Oil
hi("OilDir",     { fg = p.cyan, bold = true })
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
