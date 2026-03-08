-- GNOME Adwaita color palette
-- Based on the official GNOME Human Interface Guidelines
-- https://developer.gnome.org/hig/reference/palette.html

local M = {}

---------------------------------------------------------------------------
-- RAW PALETTE: All 45 official GNOME HIG colors
---------------------------------------------------------------------------

M.blue1 = '#99c1f1'
M.blue2 = '#62a0ea'
M.blue3 = '#3584e4'
M.blue4 = '#1c71d8'
M.blue5 = '#1a5fb4'

M.green1 = '#8ff0a4'
M.green2 = '#57e389'
M.green3 = '#33d17a'
M.green4 = '#2ec27e'
M.green5 = '#26a269'

M.yellow1 = '#f9f06b'
M.yellow2 = '#f8e45c'
M.yellow3 = '#f6d32d'
M.yellow4 = '#f5c211'
M.yellow5 = '#e5a50a'

M.orange1 = '#ffbe6f'
M.orange2 = '#ffa348'
M.orange3 = '#ff7800'
M.orange4 = '#e66100'
M.orange5 = '#c64600'

M.red1 = '#f66151'
M.red2 = '#ed333b'
M.red3 = '#e01b24'
M.red4 = '#c01c28'
M.red5 = '#a51d2d'

M.purple1 = '#dc8add'
M.purple2 = '#c061cb'
M.purple3 = '#9141ac'
M.purple4 = '#813d9c'
M.purple5 = '#613583'

M.brown1 = '#cdab8f'
M.brown2 = '#b5835a'
M.brown3 = '#986a44'
M.brown4 = '#865e3c'
M.brown5 = '#63452c'

M.light1 = '#ffffff'
M.light2 = '#f6f5f4'
M.light3 = '#deddda'
M.light4 = '#c0bfbc'
M.light5 = '#9a9996'

M.dark1 = '#77767b'
M.dark2 = '#5e5c64'
M.dark3 = '#3d3846'
M.dark4 = '#241f31'
M.dark5 = '#000000'

---------------------------------------------------------------------------
-- SEMANTIC ALIASES: Dark theme mappings
---------------------------------------------------------------------------

-- Backgrounds
M.bg = '#1c1c1f' -- View background (Adwaita dark)
M.bg_float = '#242424' -- Window/float background
M.bg_surface = '#303030' -- Card/header background
M.bg_visual = '#3d3846' -- Visual selection (Dark 3)
M.bg_cursorline = '#2a2a2a' -- Subtle cursor line
M.bg_search = '#4a3a1a' -- Search highlight (warm amber tint)
M.bg_incsearch = '#5e4a0e' -- Incremental search

-- Foregrounds
M.fg = '#f6f5f4' -- Primary text (Light 2)
M.fg_dim = '#c0bfbc' -- Secondary text (Light 4)
M.fg_muted = '#9a9996' -- Muted/tertiary text (Light 5)
M.fg_dark = '#77767b' -- De-emphasized text (Dark 1)
M.fg_faint = '#5e5c64' -- Very subtle (Dark 2)

-- Borders and separators
M.border = '#3d3846' -- Border color (Dark 3)
M.border_light = '#5e5c64' -- Lighter borders (Dark 2)

-- Accent
M.accent = '#62a0ea' -- Primary accent (Blue 2)
M.accent_light = '#99c1f1' -- Light accent (Blue 1)
M.accent_strong = '#3584e4' -- Strong accent (Blue 3)

-- Semantic colors
M.error = '#f66151' -- Red 1
M.warning = '#f9f06b' -- Yellow 1
M.info = '#62a0ea' -- Blue 2
M.hint = '#c061cb' -- Purple 2
M.success = '#57e389' -- Green 2

-- Syntax semantic aliases
M.keyword = '#c061cb' -- Purple 2 (keywords, control flow)
M.func = '#62a0ea' -- Blue 2 (functions)
M.func_builtin = '#99c1f1' -- Blue 1 (builtins)
M.string = '#57e389' -- Green 2 (strings)
M.string_escape = '#33d17a' -- Green 3 (escape sequences)
M.number = '#ffbe6f' -- Orange 1 (numbers, constants)
M.boolean = '#f66151' -- Red 1 (booleans)
M.type = '#cdab8f' -- Brown 1 (types)
M.type_builtin = '#b5835a' -- Brown 2 (builtin types)
M.property = '#99c1f1' -- Blue 1 (properties, fields)
M.parameter = '#deddda' -- Light 3 (parameters)
M.operator = '#f6f5f4' -- Light 2 (operators)
M.decorator = '#f9f06b' -- Yellow 1 (decorators, attributes)
M.namespace = '#dc8add' -- Purple 1 (namespaces, modules)
M.preproc = '#f66151' -- Red 1 (preprocessor)
M.macro = '#f66151' -- Red 1 (macros)
M.comment = '#9a9996' -- Light 5 (comments)
M.delimiter = '#9a9996' -- Light 5 (brackets, punctuation)
M.special = '#dc8add' -- Purple 1 (special characters)
M.tag = '#62a0ea' -- Blue 2 (tags)
M.link = '#3584e4' -- Blue 3 (links)

-- Diff
M.diff_add = '#26a269' -- Green 5
M.diff_change = '#e5a50a' -- Yellow 5
M.diff_delete = '#a51d2d' -- Red 5
M.diff_add_bg = '#1a3a2a' -- Subtle green tint
M.diff_change_bg = '#2a2a1a' -- Subtle yellow tint
M.diff_delete_bg = '#3a1a1a' -- Subtle red tint
M.diff_text_bg = '#3a3a1a' -- Changed text within line

return M
