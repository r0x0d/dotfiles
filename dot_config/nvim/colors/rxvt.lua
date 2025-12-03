local colors = {
  black   = "#000000",
  red     = "#cd0000",
  green   = "#00cd00",
  yellow  = "#cdcd00",

  -- softened blues
  blue        = "#5f87d7",
  magenta     = "#cd00cd",
  cyan        = "#00cdcd",
  white       = "#faebd7",

  bright_black   = "#404040",
  bright_red     = "#ff0000",
  bright_green   = "#00ff00",
  bright_yellow  = "#ffff00",

  -- softened bright blue
  bright_blue    = "#87afff",
  bright_magenta = "#ff00ff",
  bright_cyan    = "#00ffff",
  bright_white   = "#ffffff",

  bg = "#000000",
  fg = "#faebd7",
}

vim.cmd("hi clear")
vim.o.background = "dark"
vim.g.colors_name = "rxvt"

local function hi(group, opts)
  local parts = { "hi", group }
  if opts.fg then table.insert(parts, "guifg=" .. opts.fg) end
  if opts.bg then table.insert(parts, "guibg=" .. opts.bg) end
  if opts.sp then table.insert(parts, "guisp=" .. opts.sp) end

  local attrs = {}
  if opts.bold then table.insert(attrs, "bold") end
  if opts.italic then table.insert(attrs, "italic") end
  if opts.underline then table.insert(attrs, "underline") end
  if #attrs > 0 then table.insert(parts, "gui=" .. table.concat(attrs, ",")) end

  vim.cmd(table.concat(parts, " "))
end

-- UI
hi("Normal",      { fg = colors.fg, bg = colors.bg })
hi("CursorLine",  { bg = colors.bright_black })
hi("CursorColumn",{ bg = colors.bright_black })
hi("LineNr",      { fg = colors.bright_black })
hi("CursorLineNr",{ fg = colors.yellow })

-- softened visual background
hi("Visual",      { bg = "#3a3f5a" })

hi("Search",      { fg = colors.black, bg = colors.yellow })
hi("IncSearch",   { fg = colors.black, bg = colors.bright_yellow })
hi("StatusLine",  { fg = colors.fg, bg = colors.black })

-- Syntax
hi("Comment",     { fg = colors.bright_black, italic = true })
hi("Constant",    { fg = colors.cyan })
hi("String",      { fg = colors.green })
hi("Identifier",  { fg = colors.blue })
hi("Statement",   { fg = colors.red })
hi("PreProc",     { fg = colors.magenta })
hi("Type",        { fg = colors.yellow })
hi("Special",     { fg = colors.bright_blue })
hi("Error",       { fg = colors.white, bg = colors.red })
hi("Todo",        { fg = colors.black, bg = colors.yellow })

