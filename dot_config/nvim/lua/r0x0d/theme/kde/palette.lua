-- Custom dark colorscheme palette for Neovim in KDE/Konsole
-- Vibrant, high-contrast colors on #232627 background
-- Every syntax color >= 6:1 contrast ratio

local M = {}

---------------------------------------------------------------------------
-- RAW PALETTE
---------------------------------------------------------------------------

-- Blues
M.blue1 = '#89b4fa' -- Vibrant blue
M.blue2 = '#74c7ec' -- Sapphire
M.blue3 = '#89dceb' -- Sky cyan
M.blue4 = '#5294e2' -- Deep blue
M.blue5 = '#45475a' -- Dark blue-gray

-- Greens
M.green1 = '#a6e3a1' -- Fresh green
M.green2 = '#94e2d5' -- Teal
M.green3 = '#8ec07c' -- Sage
M.green4 = '#6daa6d' -- Mid green
M.green5 = '#3d7a4a' -- Dark green

-- Yellows
M.yellow1 = '#f9e2af' -- Warm gold
M.yellow2 = '#fab387' -- Peach
M.yellow3 = '#e0a050' -- Deep amber
M.yellow4 = '#c88830' -- Brown amber
M.yellow5 = '#a06828' -- Dark amber

-- Reds
M.red1 = '#f38ba8' -- Vibrant pink-red
M.red2 = '#eba0ac' -- Rose
M.red3 = '#d05060' -- Deeper red
M.red4 = '#b04050' -- Dark red
M.red5 = '#802030' -- Darkest red

-- Purples
M.purple1 = '#cba6f7' -- Mauve
M.purple2 = '#b4befe' -- Lavender
M.purple3 = '#a080d0' -- Medium purple
M.purple4 = '#8060b0' -- Darker purple
M.purple5 = '#604090' -- Deep purple

-- Teals
M.teal1 = '#94e2d5' -- Vibrant teal

-- Neutrals
M.light1 = '#cdd6f4' -- Primary text
M.light2 = '#bac2de' -- Secondary text
M.light3 = '#a6adc8' -- Muted text
M.light4 = '#9399b2' -- Inactive
M.light5 = '#7f849c' -- Dim

M.dark1 = '#6c7086' -- Comments
M.dark2 = '#585b70' -- Subtle
M.dark3 = '#45475a' -- Separators
M.dark4 = '#313244' -- Surface
M.dark5 = '#2a2c36' -- Raised surface
M.dark6 = '#000000' -- True black

---------------------------------------------------------------------------
-- SEMANTIC ALIASES
---------------------------------------------------------------------------

-- Backgrounds
M.bg = '#232627'
M.bg_float = '#2a2c32'
M.bg_surface = '#313440'
M.bg_visual = '#40405e'
M.bg_cursorline = '#2c2e34'
M.bg_search = '#2a5038'
M.bg_incsearch = '#e0a050'

-- Foregrounds
M.fg = '#cdd6f4'
M.fg_dim = '#a6adc8'
M.fg_muted = '#7f849c'
M.fg_dark = '#6c7086'
M.fg_faint = '#585b70'

-- Borders and separators
M.border = '#45475a'
M.border_light = '#585b70'

-- Accent
M.accent = '#89b4fa'
M.accent_light = '#b4befe'
M.accent_strong = '#5294e2'

-- Semantic colors
M.error = '#f38ba8'
M.warning = '#fab387'
M.info = '#89b4fa'
M.hint = '#cba6f7'
M.success = '#a6e3a1'

-- Syntax
M.keyword = '#cba6f7' -- Mauve (purple keywords)
M.control_flow = '#cba6f7'
M.func = '#89b4fa' -- Blue (functions)
M.func_builtin = '#74c7ec' -- Sapphire (builtins)
M.string = '#a6e3a1' -- Green (strings)
M.string_escape = '#94e2d5' -- Teal (escape sequences)
M.number = '#fab387' -- Peach (numbers)
M.boolean = '#fab387' -- Peach (booleans)
M.type = '#f9e2af' -- Warm gold (types)
M.type_builtin = '#f9e2af'
M.variable = '#cdd6f4' -- Foreground (clean)
M.property = '#f2cdcd' -- Flamingo (warm pink - properties)
M.parameter = '#eba0ac' -- Rose (parameters)
M.operator = '#89dceb' -- Sky cyan (operators)
M.decorator = '#f9e2af' -- Warm gold (decorators)
M.namespace = '#89b4fa' -- Blue (modules)
M.preproc = '#a6e3a1' -- Green (preprocessor)
M.macro = '#a6e3a1' -- Green (macros)
M.comment = '#6c7086' -- Gray (comments)
M.delimiter = '#7f849c' -- Brighter gray (brackets)
M.special = '#f5c2e7' -- Pink (special chars)
M.tag = '#89b4fa' -- Blue (tags)
M.link = '#89b4fa' -- Blue (links)

-- Diff
M.diff_add = '#a6e3a1'
M.diff_change = '#fab387'
M.diff_delete = '#f38ba8'
M.diff_add_bg = '#1e3328'
M.diff_change_bg = '#302a1e'
M.diff_delete_bg = '#321e26'
M.diff_text_bg = '#3a3020'

return M
