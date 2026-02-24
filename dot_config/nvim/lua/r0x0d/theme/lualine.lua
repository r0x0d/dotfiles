-- Custom lualine theme

local p = require 'r0x0d.theme.palette'

local theme = {
    normal = {
        a = { fg = p.light1, bg = p.blue1, gui = 'bold' },
        b = { fg = p.fg, bg = p.bg_surface },
        c = { fg = p.fg_dim, bg = p.bg_float },
    },
    insert = {
        a = { fg = p.light1, bg = p.green1, gui = 'bold' },
        b = { fg = p.fg, bg = p.bg_surface },
        c = { fg = p.fg_dim, bg = p.bg_float },
    },
    visual = {
        a = { fg = p.light1, bg = p.purple1, gui = 'bold' },
        b = { fg = p.fg, bg = p.bg_surface },
        c = { fg = p.fg_dim, bg = p.bg_float },
    },
    replace = {
        a = { fg = p.light1, bg = p.red2, gui = 'bold' },
        b = { fg = p.fg, bg = p.bg_surface },
        c = { fg = p.fg_dim, bg = p.bg_float },
    },
    command = {
        a = { fg = p.light1, bg = p.yellow2, gui = 'bold' },
        b = { fg = p.fg, bg = p.bg_surface },
        c = { fg = p.fg_dim, bg = p.bg_float },
    },
    terminal = {
        a = { fg = p.light1, bg = p.teal1, gui = 'bold' },
        b = { fg = p.fg, bg = p.bg_surface },
        c = { fg = p.fg_dim, bg = p.bg_float },
    },
    inactive = {
        a = { fg = p.fg_muted, bg = p.bg_float },
        b = { fg = p.fg_muted, bg = p.bg_float },
        c = { fg = p.fg_dark, bg = p.bg_float },
    },
}

return theme
