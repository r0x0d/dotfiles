-- GNOME Adwaita highlight group definitions
-- Organized by category: editor, syntax, treesitter, plugins, etc.

local p = require 'r0x0d.theme.gnome.palette'

local M = {}

--- Helper to set a table of highlight groups.
---@param groups table<string, vim.api.keyset.highlight>
local function hi(groups)
    for name, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

--- Apply all highlight groups.
function M.setup()
    ---------------------------------------------------------------------------
    -- EDITOR
    ---------------------------------------------------------------------------
    hi {
        Normal = { fg = p.fg, bg = p.bg },
        NormalNC = { fg = p.fg, bg = p.bg },
        NormalFloat = { fg = p.fg, bg = p.bg_float },
        FloatBorder = { fg = p.border_light, bg = p.bg_float },
        FloatTitle = { fg = p.accent, bg = p.bg_float, bold = true },
        Cursor = { fg = p.bg, bg = p.fg },
        lCursor = { fg = p.bg, bg = p.fg },
        CursorIM = { fg = p.bg, bg = p.fg },
        CursorLine = { bg = p.bg_cursorline },
        CursorLineNr = { fg = p.accent, bold = true },
        CursorColumn = { bg = p.bg_cursorline },
        ColorColumn = { bg = p.bg_cursorline },
        LineNr = { fg = p.fg_dark },
        SignColumn = { fg = p.fg_dark, bg = p.bg },
        FoldColumn = { fg = p.fg_faint, bg = p.bg },
        Folded = { fg = p.fg_muted, bg = p.bg_float },
        VertSplit = { fg = p.border },
        WinSeparator = { fg = p.border },
        Visual = { bg = p.bg_visual },
        VisualNOS = { bg = p.bg_visual },
        Search = { fg = p.fg, bg = p.bg_search },
        IncSearch = { fg = p.light1, bg = p.orange3, bold = true },
        CurSearch = { fg = p.light1, bg = p.orange3, bold = true },
        Substitute = { fg = p.light1, bg = p.red3 },
        MatchParen = { fg = p.orange1, bold = true, underline = true },
        Pmenu = { fg = p.fg, bg = p.bg_float },
        PmenuSel = { fg = p.fg, bg = p.bg_visual },
        PmenuSbar = { bg = p.bg_surface },
        PmenuThumb = { bg = p.fg_dark },
        StatusLine = { fg = p.fg, bg = p.bg_surface },
        StatusLineNC = { fg = p.fg_muted, bg = p.bg_float },
        TabLine = { fg = p.fg_muted, bg = p.bg_float },
        TabLineFill = { bg = p.bg },
        TabLineSel = { fg = p.fg, bg = p.bg_surface, bold = true },
        WinBar = { fg = p.fg_dim, bg = p.bg },
        WinBarNC = { fg = p.fg_muted, bg = p.bg },
        WildMenu = { fg = p.fg, bg = p.bg_visual },
        Directory = { fg = p.accent },
        Title = { fg = p.accent, bold = true },
        ErrorMsg = { fg = p.error, bold = true },
        WarningMsg = { fg = p.warning, bold = true },
        ModeMsg = { fg = p.fg_dim, bold = true },
        MoreMsg = { fg = p.success },
        Question = { fg = p.success },
        NonText = { fg = p.fg_faint },
        SpecialKey = { fg = p.fg_faint },
        Whitespace = { fg = p.fg_faint },
        EndOfBuffer = { fg = p.fg_faint },
        Conceal = { fg = p.fg_dark },
        SpellBad = { undercurl = true, sp = p.error },
        SpellCap = { undercurl = true, sp = p.warning },
        SpellLocal = { undercurl = true, sp = p.info },
        SpellRare = { undercurl = true, sp = p.hint },
        QuickFixLine = { bg = p.bg_visual, bold = true },
        TermCursor = { fg = p.bg, bg = p.fg },
        TermCursorNC = { fg = p.bg, bg = p.fg_muted },

        -- Diff
        DiffAdd = { bg = p.diff_add_bg },
        DiffChange = { bg = p.diff_change_bg },
        DiffDelete = { bg = p.diff_delete_bg },
        DiffText = { bg = p.diff_text_bg },
        Added = { fg = p.success },
        Changed = { fg = p.warning },
        Removed = { fg = p.error },
    }

    ---------------------------------------------------------------------------
    -- BASE SYNTAX (Vim's built-in groups)
    ---------------------------------------------------------------------------
    hi {
        Comment = { fg = p.comment, italic = true },
        Constant = { fg = p.number },
        String = { fg = p.string },
        Character = { fg = p.string },
        Number = { fg = p.number },
        Boolean = { fg = p.boolean },
        Float = { fg = p.number },
        Identifier = { fg = p.fg },
        Function = { fg = p.func },
        Statement = { fg = p.keyword },
        Conditional = { fg = p.keyword },
        Repeat = { fg = p.keyword },
        Label = { fg = p.keyword },
        Operator = { fg = p.operator },
        Keyword = { fg = p.keyword },
        Exception = { fg = p.keyword },
        PreProc = { fg = p.preproc },
        Include = { fg = p.keyword },
        Define = { fg = p.preproc },
        Macro = { fg = p.macro },
        PreCondit = { fg = p.preproc },
        Type = { fg = p.type },
        StorageClass = { fg = p.keyword },
        Structure = { fg = p.type },
        Typedef = { fg = p.type },
        Special = { fg = p.special },
        SpecialChar = { fg = p.string_escape },
        Tag = { fg = p.tag },
        Delimiter = { fg = p.delimiter },
        SpecialComment = { fg = p.comment, bold = true },
        Debug = { fg = p.orange1 },
        Underlined = { fg = p.link, underline = true },
        Ignore = { fg = p.fg_faint },
        Error = { fg = p.error },
        Todo = { fg = p.yellow1, bg = p.bg_surface, bold = true },
    }

    ---------------------------------------------------------------------------
    -- TREESITTER: Generic highlight groups
    ---------------------------------------------------------------------------
    hi {
        -- Identifiers
        ['@variable'] = { fg = p.fg },
        ['@variable.builtin'] = { fg = p.red1, italic = true },
        ['@variable.parameter'] = { fg = p.parameter },
        ['@variable.member'] = { fg = p.property },

        -- Constants
        ['@constant'] = { fg = p.number },
        ['@constant.builtin'] = { fg = p.number, bold = true },
        ['@constant.macro'] = { fg = p.macro },

        -- Modules / Namespaces
        ['@module'] = { fg = p.namespace },
        ['@module.builtin'] = { fg = p.namespace, italic = true },

        -- Labels
        ['@label'] = { fg = p.blue1 },

        -- Strings
        ['@string'] = { fg = p.string },
        ['@string.documentation'] = { fg = p.string, italic = true },
        ['@string.escape'] = { fg = p.string_escape, bold = true },
        ['@string.regex'] = { fg = p.orange1 },
        ['@string.special'] = { fg = p.special },
        ['@string.special.symbol'] = { fg = p.orange1 },
        ['@string.special.url'] = { fg = p.link, underline = true },
        ['@string.special.path'] = { fg = p.blue1 },

        -- Characters
        ['@character'] = { fg = p.string },
        ['@character.special'] = { fg = p.string_escape },

        -- Booleans
        ['@boolean'] = { fg = p.boolean },

        -- Numbers
        ['@number'] = { fg = p.number },
        ['@number.float'] = { fg = p.number },

        -- Types
        ['@type'] = { fg = p.type },
        ['@type.builtin'] = { fg = p.type_builtin, italic = true },
        ['@type.definition'] = { fg = p.type },
        ['@type.qualifier'] = { fg = p.keyword },

        -- Attributes / Decorators
        ['@attribute'] = { fg = p.decorator },
        ['@attribute.builtin'] = { fg = p.decorator, italic = true },

        -- Properties
        ['@property'] = { fg = p.property },

        -- Functions
        ['@function'] = { fg = p.func },
        ['@function.builtin'] = { fg = p.func_builtin },
        ['@function.call'] = { fg = p.func },
        ['@function.macro'] = { fg = p.macro },
        ['@function.method'] = { fg = p.func },
        ['@function.method.call'] = { fg = p.func },

        -- Constructors
        ['@constructor'] = { fg = p.type },

        -- Operators
        ['@operator'] = { fg = p.operator },

        -- Keywords
        ['@keyword'] = { fg = p.keyword },
        ['@keyword.coroutine'] = { fg = p.keyword, italic = true },
        ['@keyword.function'] = { fg = p.keyword },
        ['@keyword.operator'] = { fg = p.keyword },
        ['@keyword.import'] = { fg = p.keyword },
        ['@keyword.type'] = { fg = p.keyword },
        ['@keyword.modifier'] = { fg = p.keyword },
        ['@keyword.repeat'] = { fg = p.keyword },
        ['@keyword.return'] = { fg = p.keyword, bold = true },
        ['@keyword.debug'] = { fg = p.orange1 },
        ['@keyword.exception'] = { fg = p.keyword, bold = true },
        ['@keyword.conditional'] = { fg = p.keyword },
        ['@keyword.conditional.ternary'] = { fg = p.keyword },
        ['@keyword.directive'] = { fg = p.preproc },
        ['@keyword.directive.define'] = { fg = p.preproc },

        -- Punctuation
        ['@punctuation.bracket'] = { fg = p.delimiter },
        ['@punctuation.delimiter'] = { fg = p.delimiter },
        ['@punctuation.special'] = { fg = p.special },

        -- Comments
        ['@comment'] = { fg = p.comment, italic = true },
        ['@comment.documentation'] = { fg = p.comment, italic = true },
        ['@comment.error'] = { fg = p.error, bold = true },
        ['@comment.warning'] = { fg = p.warning, bold = true },
        ['@comment.todo'] = { fg = p.yellow1, bold = true },
        ['@comment.note'] = { fg = p.info, bold = true },

        -- Markup (Markdown, etc.)
        ['@markup.strong'] = { bold = true },
        ['@markup.italic'] = { italic = true },
        ['@markup.strikethrough'] = { strikethrough = true },
        ['@markup.underline'] = { underline = true },
        ['@markup.heading'] = { fg = p.accent, bold = true },
        ['@markup.heading.1'] = { fg = p.accent, bold = true },
        ['@markup.heading.2'] = { fg = p.blue1, bold = true },
        ['@markup.heading.3'] = { fg = p.purple1, bold = true },
        ['@markup.heading.4'] = { fg = p.green2, bold = true },
        ['@markup.heading.5'] = { fg = p.orange1, bold = true },
        ['@markup.heading.6'] = { fg = p.red1, bold = true },
        ['@markup.quote'] = { fg = p.fg_dim, italic = true },
        ['@markup.math'] = { fg = p.orange1 },
        ['@markup.environment'] = { fg = p.keyword },
        ['@markup.link'] = { fg = p.link, underline = true },
        ['@markup.link.label'] = { fg = p.blue1 },
        ['@markup.link.url'] = { fg = p.link, underline = true },
        ['@markup.raw'] = { fg = p.green1 },
        ['@markup.raw.block'] = { fg = p.fg_dim },
        ['@markup.list'] = { fg = p.accent },
        ['@markup.list.checked'] = { fg = p.success },
        ['@markup.list.unchecked'] = { fg = p.fg_muted },

        -- Tags (HTML, XML)
        ['@tag'] = { fg = p.tag },
        ['@tag.attribute'] = { fg = p.decorator },
        ['@tag.delimiter'] = { fg = p.delimiter },

        -- Diff (treesitter)
        ['@diff.plus'] = { fg = p.success },
        ['@diff.minus'] = { fg = p.error },
        ['@diff.delta'] = { fg = p.warning },
    }

    ---------------------------------------------------------------------------
    -- TREESITTER: Language-specific overrides
    ---------------------------------------------------------------------------
    hi {
        -- Python
        ['@variable.builtin.python'] = { fg = p.red1, italic = true }, -- self, cls
        ['@attribute.python'] = { fg = p.decorator }, -- decorators
        ['@keyword.import.python'] = { fg = p.keyword, italic = true }, -- import, from
        ['@string.documentation.python'] = { fg = p.comment, italic = true }, -- docstrings
        ['@function.builtin.python'] = { fg = p.func_builtin }, -- print, len, etc.
        ['@type.builtin.python'] = { fg = p.type_builtin, italic = true }, -- int, str, list

        -- Rust
        ['@keyword.modifier.rust'] = { fg = p.keyword, bold = true }, -- pub, mut
        ['@function.macro.rust'] = { fg = p.macro, bold = true }, -- println!, vec!
        ['@constant.builtin.rust'] = { fg = p.number, bold = true }, -- true, false, None
        ['@type.builtin.rust'] = { fg = p.type_builtin, italic = true }, -- u32, String, Vec
        ['@variable.builtin.rust'] = { fg = p.red1, italic = true }, -- self
        ['@keyword.type.rust'] = { fg = p.keyword }, -- struct, enum, impl, trait
        ['@string.special.symbol.rust'] = { fg = p.orange1 }, -- lifetimes: 'a

        -- C / C++
        ['@keyword.directive.c'] = { fg = p.preproc }, -- #include, #define
        ['@keyword.directive.define.c'] = { fg = p.preproc },
        ['@keyword.directive.cpp'] = { fg = p.preproc },
        ['@keyword.directive.define.cpp'] = { fg = p.preproc },
        ['@type.builtin.c'] = { fg = p.type_builtin, italic = true },
        ['@type.builtin.cpp'] = { fg = p.type_builtin, italic = true },
        ['@constant.macro.c'] = { fg = p.macro },
        ['@constant.macro.cpp'] = { fg = p.macro },

        -- Zig
        ['@keyword.modifier.zig'] = { fg = p.keyword, bold = true }, -- comptime, pub
        ['@function.builtin.zig'] = { fg = p.func_builtin },
        ['@type.builtin.zig'] = { fg = p.type_builtin, italic = true },
        ['@variable.builtin.zig'] = { fg = p.red1, italic = true },

        -- Markdown
        ['@markup.heading.1.markdown'] = { fg = p.accent, bold = true },
        ['@markup.heading.2.markdown'] = { fg = p.blue1, bold = true },
        ['@markup.heading.3.markdown'] = { fg = p.purple1, bold = true },
        ['@markup.heading.4.markdown'] = { fg = p.green2, bold = true },
        ['@markup.heading.5.markdown'] = { fg = p.orange1, bold = true },
        ['@markup.heading.6.markdown'] = { fg = p.red1, bold = true },
        ['@markup.raw.markdown_inline'] = { fg = p.green1, bg = p.bg_float },
        ['@markup.link.markdown_inline'] = { fg = p.link, underline = true },

        -- YAML
        ['@property.yaml'] = { fg = p.blue1 },
        ['@string.yaml'] = { fg = p.string },
        ['@boolean.yaml'] = { fg = p.boolean },
        ['@number.yaml'] = { fg = p.number },
        ['@constant.builtin.yaml'] = { fg = p.number, bold = true }, -- null, ~

        -- JSON
        ['@property.json'] = { fg = p.blue1 },
        ['@string.json'] = { fg = p.string },
        ['@number.json'] = { fg = p.number },
        ['@boolean.json'] = { fg = p.boolean },
        ['@property.jsonc'] = { fg = p.blue1 },
        ['@comment.jsonc'] = { fg = p.comment, italic = true },

        -- RPM spec (uses vim syntax highlight groups if no treesitter parser)
        -- Covered by base syntax groups below
    }

    ---------------------------------------------------------------------------
    -- RPM SPEC FILES (vim syntax, no treesitter parser available)
    ---------------------------------------------------------------------------
    hi {
        specSection = { fg = p.accent, bold = true }, -- %description, %prep, etc.
        specMacroIdentifier = { fg = p.macro }, -- %{name}, %{version}
        specSectionMacro = { fg = p.macro, bold = true },
        specCommand = { fg = p.func },
        specConditional = { fg = p.keyword },
        specTag = { fg = p.blue1, bold = true }, -- Name:, Version:, etc.
        specTagValue = { fg = p.fg },
        specChangelog = { fg = p.fg_dim },
        specChangelogEntry = { fg = p.fg },
        specDate = { fg = p.orange1 },
        specEmail = { fg = p.link },
        specURL = { fg = p.link, underline = true },
        specComment = { fg = p.comment, italic = true },
        specString = { fg = p.string },
    }

    ---------------------------------------------------------------------------
    -- DIAGNOSTICS
    ---------------------------------------------------------------------------
    hi {
        DiagnosticError = { fg = p.error },
        DiagnosticWarn = { fg = p.yellow3 },
        DiagnosticInfo = { fg = p.info },
        DiagnosticHint = { fg = p.hint },
        DiagnosticOk = { fg = p.success },
        DiagnosticUnderlineError = { undercurl = true, sp = p.error },
        DiagnosticUnderlineWarn = { undercurl = true, sp = p.yellow3 },
        DiagnosticUnderlineInfo = { undercurl = true, sp = p.info },
        DiagnosticUnderlineHint = { undercurl = true, sp = p.hint },
        DiagnosticUnderlineOk = { undercurl = true, sp = p.success },
        DiagnosticVirtualTextError = { fg = p.error, bg = '#2d1a1a' },
        DiagnosticVirtualTextWarn = { fg = p.yellow3, bg = '#2a2a1a' },
        DiagnosticVirtualTextInfo = { fg = p.info, bg = '#1a1a2d' },
        DiagnosticVirtualTextHint = { fg = p.hint, bg = '#2a1a2d' },
        DiagnosticVirtualTextOk = { fg = p.success, bg = '#1a2a1a' },
        DiagnosticSignError = { fg = p.error },
        DiagnosticSignWarn = { fg = p.yellow3 },
        DiagnosticSignInfo = { fg = p.info },
        DiagnosticSignHint = { fg = p.hint },
        DiagnosticSignOk = { fg = p.success },
        DiagnosticFloatingError = { fg = p.error },
        DiagnosticFloatingWarn = { fg = p.yellow3 },
        DiagnosticFloatingInfo = { fg = p.info },
        DiagnosticFloatingHint = { fg = p.hint },
        DiagnosticFloatingOk = { fg = p.success },
        DiagnosticDeprecated = { fg = p.fg_muted, strikethrough = true },
        DiagnosticUnnecessary = { fg = p.fg_dark, italic = true },
    }

    ---------------------------------------------------------------------------
    -- LSP
    ---------------------------------------------------------------------------
    hi {
        LspReferenceText = { bg = p.bg_visual },
        LspReferenceRead = { bg = p.bg_visual },
        LspReferenceWrite = { bg = p.bg_visual, bold = true },
        LspSignatureActiveParameter = { fg = p.accent, bold = true },
        LspCodeLens = { fg = p.fg_dark, italic = true },
        LspInlayHint = { fg = p.fg_faint, bg = p.bg_cursorline, italic = true },
    }

    ---------------------------------------------------------------------------
    -- GIT SIGNS
    ---------------------------------------------------------------------------
    hi {
        GitSignsAdd = { fg = p.success },
        GitSignsChange = { fg = p.yellow3 },
        GitSignsDelete = { fg = p.error },
        GitSignsCurrentLineBlame = { fg = p.fg_faint, italic = true },
        GitSignsAddNr = { fg = p.success },
        GitSignsChangeNr = { fg = p.yellow3 },
        GitSignsDeleteNr = { fg = p.error },
        GitSignsAddLn = { bg = p.diff_add_bg },
        GitSignsChangeLn = { bg = p.diff_change_bg },
        GitSignsDeleteLn = { bg = p.diff_delete_bg },
    }

    ---------------------------------------------------------------------------
    -- TELESCOPE
    ---------------------------------------------------------------------------
    hi {
        TelescopeNormal = { fg = p.fg, bg = p.bg_float },
        TelescopeBorder = { fg = p.border_light, bg = p.bg_float },
        TelescopeTitle = { fg = p.accent, bg = p.bg_float, bold = true },

        TelescopePromptNormal = { fg = p.fg, bg = p.bg_float },
        TelescopePromptBorder = { fg = p.border_light, bg = p.bg_float },
        TelescopePromptTitle = { fg = p.accent, bg = p.bg_float, bold = true },
        TelescopePromptPrefix = { fg = p.accent },
        TelescopePromptCounter = { fg = p.fg_muted },

        TelescopeResultsNormal = { fg = p.fg, bg = p.bg_float },
        TelescopeResultsBorder = { fg = p.border_light, bg = p.bg_float },
        TelescopeResultsTitle = { fg = p.accent, bg = p.bg_float, bold = true },

        TelescopePreviewNormal = { fg = p.fg, bg = p.bg_float },
        TelescopePreviewBorder = { fg = p.border_light, bg = p.bg_float },
        TelescopePreviewTitle = { fg = p.accent, bg = p.bg_float, bold = true },

        TelescopeSelection = { fg = p.fg, bg = p.bg_visual },
        TelescopeSelectionCaret = { fg = p.accent },
        TelescopeMultiSelection = { fg = p.accent },
        TelescopeMultiIcon = { fg = p.accent },

        TelescopeMatching = { fg = p.accent, bold = true },
    }

    ---------------------------------------------------------------------------
    -- LAZY.NVIM
    ---------------------------------------------------------------------------
    hi {
        LazyNormal = { fg = p.fg, bg = p.bg_float },
        LazyBackdrop = { bg = p.dark5 },
        LazyH1 = { fg = p.light1, bg = p.accent_strong, bold = true },
        LazyH2 = { fg = p.accent, bold = true },
        LazyButton = { fg = p.fg, bg = p.bg_surface },
        LazyButtonActive = { fg = p.light1, bg = p.accent_strong, bold = true },
        LazyComment = { fg = p.comment },
        LazySpecial = { fg = p.accent },
        LazyLocal = { fg = p.orange1 },
        LazyNoCond = { fg = p.yellow3 },
        LazyCommit = { fg = p.fg_muted },
        LazyCommitIssue = { fg = p.number },
        LazyCommitType = { fg = p.accent, bold = true },
        LazyCommitScope = { fg = p.fg_dim, italic = true },
        LazyReasonPlugin = { fg = p.purple1 },
        LazyReasonCmd = { fg = p.func },
        LazyReasonEvent = { fg = p.orange1 },
        LazyReasonKeys = { fg = p.green2 },
        LazyReasonStart = { fg = p.yellow1 },
        LazyReasonFt = { fg = p.type },
        LazyReasonRuntime = { fg = p.red1 },
        LazyReasonSource = { fg = p.string },
        LazyReasonImport = { fg = p.fg },
        LazyReasonRequire = { fg = p.parameter },
        LazyDimmed = { fg = p.fg_dark },
        LazyProp = { fg = p.fg_muted },
        LazyValue = { fg = p.string },
        LazyUrl = { fg = p.link, underline = true },
        LazyDir = { fg = p.accent },
        LazyTaskOutput = { fg = p.fg },
        LazyError = { fg = p.error },
        LazyWarning = { fg = p.yellow3 },
        LazyInfo = { fg = p.info },
        LazyProgressDone = { fg = p.success },
        LazyProgressTodo = { fg = p.fg_faint },
        LazyBold = { bold = true },
        LazyItalic = { italic = true },
    }

    ---------------------------------------------------------------------------
    -- BLINK.CMP (completion)
    ---------------------------------------------------------------------------
    hi {
        BlinkCmpMenu = { fg = p.fg, bg = p.bg_float },
        BlinkCmpMenuBorder = { fg = p.border_light, bg = p.bg_float },
        BlinkCmpMenuSelection = { bg = p.bg_visual },
        BlinkCmpDoc = { fg = p.fg, bg = p.bg_float },
        BlinkCmpDocBorder = { fg = p.border_light, bg = p.bg_float },
        BlinkCmpDocSeparator = { fg = p.border_light, bg = p.bg_float },
        BlinkCmpLabel = { fg = p.fg },
        BlinkCmpLabelDeprecated = { fg = p.fg_muted, strikethrough = true },
        BlinkCmpLabelMatch = { fg = p.accent, bold = true },
        BlinkCmpKind = { fg = p.accent },
        BlinkCmpKindFunction = { fg = p.func },
        BlinkCmpKindMethod = { fg = p.func },
        BlinkCmpKindVariable = { fg = p.fg },
        BlinkCmpKindField = { fg = p.property },
        BlinkCmpKindProperty = { fg = p.property },
        BlinkCmpKindClass = { fg = p.type },
        BlinkCmpKindStruct = { fg = p.type },
        BlinkCmpKindInterface = { fg = p.type },
        BlinkCmpKindModule = { fg = p.namespace },
        BlinkCmpKindKeyword = { fg = p.keyword },
        BlinkCmpKindConstant = { fg = p.number },
        BlinkCmpKindEnum = { fg = p.type },
        BlinkCmpKindEnumMember = { fg = p.number },
        BlinkCmpKindSnippet = { fg = p.green2 },
        BlinkCmpKindText = { fg = p.fg },
        BlinkCmpKindFile = { fg = p.fg_dim },
        BlinkCmpKindFolder = { fg = p.accent },
        BlinkCmpKindColor = { fg = p.orange1 },
        BlinkCmpKindValue = { fg = p.number },
        BlinkCmpGhostText = { fg = p.fg_faint, italic = true },
    }

    ---------------------------------------------------------------------------
    -- MINI (icons, etc.)
    ---------------------------------------------------------------------------
    hi {
        MiniIconsAzure = { fg = p.blue1 },
        MiniIconsBlue = { fg = p.blue2 },
        MiniIconsCyan = { fg = p.blue1 },
        MiniIconsGreen = { fg = p.green2 },
        MiniIconsGrey = { fg = p.fg_muted },
        MiniIconsOrange = { fg = p.orange1 },
        MiniIconsPurple = { fg = p.purple2 },
        MiniIconsRed = { fg = p.red1 },
        MiniIconsYellow = { fg = p.yellow1 },
    }

    ---------------------------------------------------------------------------
    -- TODO COMMENTS
    ---------------------------------------------------------------------------
    hi {
        TodoBgFIX = { fg = p.light1, bg = p.red3, bold = true },
        TodoBgTODO = { fg = p.light1, bg = p.accent_strong, bold = true },
        TodoBgHACK = { fg = p.light1, bg = p.orange3, bold = true },
        TodoBgWARN = { fg = p.light1, bg = p.yellow5, bold = true },
        TodoBgNOTE = { fg = p.light1, bg = p.green5, bold = true },
        TodoBgPERF = { fg = p.light1, bg = p.purple3, bold = true },
        TodoBgTEST = { fg = p.light1, bg = p.blue4, bold = true },
        TodoFgFIX = { fg = p.red1 },
        TodoFgTODO = { fg = p.accent },
        TodoFgHACK = { fg = p.orange1 },
        TodoFgWARN = { fg = p.yellow1 },
        TodoFgNOTE = { fg = p.green2 },
        TodoFgPERF = { fg = p.purple1 },
        TodoFgTEST = { fg = p.blue1 },
        TodoSignFIX = { fg = p.red1 },
        TodoSignTODO = { fg = p.accent },
        TodoSignHACK = { fg = p.orange1 },
        TodoSignWARN = { fg = p.yellow1 },
        TodoSignNOTE = { fg = p.green2 },
        TodoSignPERF = { fg = p.purple1 },
        TodoSignTEST = { fg = p.blue1 },
    }

    ---------------------------------------------------------------------------
    -- OIL.NVIM (file browser)
    ---------------------------------------------------------------------------
    hi {
        OilDir = { fg = p.accent, bold = true },
        OilDirIcon = { fg = p.accent },
        OilFile = { fg = p.fg },
        OilSocket = { fg = p.purple1 },
        OilLink = { fg = p.blue1 },
        OilLinkTarget = { fg = p.fg_muted, italic = true },
        OilCreate = { fg = p.success },
        OilDelete = { fg = p.error },
        OilMove = { fg = p.warning },
        OilCopy = { fg = p.info },
        OilChange = { fg = p.warning },
    }

    ---------------------------------------------------------------------------
    -- DIFFVIEW
    ---------------------------------------------------------------------------
    hi {
        DiffviewDim1 = { fg = p.fg_dark },
        DiffviewFilePanelTitle = { fg = p.accent, bold = true },
        DiffviewFilePanelCounter = { fg = p.fg_muted },
        DiffviewFilePanelFileName = { fg = p.fg },
        DiffviewFilePanelPath = { fg = p.fg_dim },
        DiffviewFilePanelInsertions = { fg = p.success },
        DiffviewFilePanelDeletions = { fg = p.error },
        DiffviewStatusAdded = { fg = p.success },
        DiffviewStatusModified = { fg = p.yellow3 },
        DiffviewStatusDeleted = { fg = p.error },
        DiffviewStatusRenamed = { fg = p.blue1 },
        DiffviewStatusUntracked = { fg = p.green1 },
    }

    ---------------------------------------------------------------------------
    -- GITSIGNS (additional)
    ---------------------------------------------------------------------------
    hi {
        GitSignsAddPreview = { bg = p.diff_add_bg },
        GitSignsDeletePreview = { bg = p.diff_delete_bg },
    }

    ---------------------------------------------------------------------------
    -- MARKDOWN PREVIEW / RENDER
    ---------------------------------------------------------------------------
    hi {
        markdownH1 = { fg = p.accent, bold = true },
        markdownH2 = { fg = p.blue1, bold = true },
        markdownH3 = { fg = p.purple1, bold = true },
        markdownH4 = { fg = p.green2, bold = true },
        markdownH5 = { fg = p.orange1, bold = true },
        markdownH6 = { fg = p.red1, bold = true },
        markdownCode = { fg = p.green1, bg = p.bg_float },
        markdownCodeBlock = { fg = p.fg_dim },
        markdownBold = { bold = true },
        markdownItalic = { italic = true },
        markdownUrl = { fg = p.link, underline = true },
        markdownLink = { fg = p.blue1 },
        markdownLinkText = { fg = p.blue1 },
        markdownListMarker = { fg = p.accent },
        markdownBlockquote = { fg = p.fg_dim, italic = true },
        markdownRule = { fg = p.border_light },
    }

    ---------------------------------------------------------------------------
    -- DAP (Debug Adapter Protocol)
    ---------------------------------------------------------------------------
    hi {
        DapBreakpoint = { fg = p.red1 },
        DapBreakpointCondition = { fg = p.orange1 },
        DapLogPoint = { fg = p.blue1 },
        DapStopped = { fg = p.green2, bg = p.diff_add_bg },
        DapStoppedLine = { bg = p.diff_add_bg },
    }

    ---------------------------------------------------------------------------
    -- NEOTEST
    ---------------------------------------------------------------------------
    hi {
        NeotestPassed = { fg = p.success },
        NeotestFailed = { fg = p.error },
        NeotestRunning = { fg = p.yellow1 },
        NeotestSkipped = { fg = p.fg_muted },
        NeotestDir = { fg = p.accent },
        NeotestFile = { fg = p.fg },
        NeotestNamespace = { fg = p.namespace },
        NeotestAdapterName = { fg = p.purple1, bold = true },
        NeotestFocused = { bold = true, underline = true },
    }

    ---------------------------------------------------------------------------
    -- GRUG-FAR (search & replace)
    ---------------------------------------------------------------------------
    hi {
        GrugFarResultsMatch = { fg = p.light1, bg = p.accent_strong, bold = true },
        GrugFarResultsPath = { fg = p.accent },
        GrugFarResultsLineNo = { fg = p.fg_dark },
        GrugFarResultsLineColumn = { fg = p.fg_dark },
        GrugFarInputLabel = { fg = p.accent, bold = true },
    }

    ---------------------------------------------------------------------------
    -- OCTO (GitHub)
    ---------------------------------------------------------------------------
    hi {
        OctoEditable = { bg = p.bg_cursorline },
        OctoBubble = { fg = p.fg, bg = p.bg_surface },
    }
end

return M
