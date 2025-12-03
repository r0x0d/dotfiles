local colors = {
  black   = "#090300",
  red     = "#db2d20",
  green   = "#01a252",
  yellow  = "#fded02",
  blue    = "#01a0e4",
  magenta = "#a16a94",
  cyan    = "#b5e4f4",
  white   = "#a5a2a2",

  bright_black   = "#5c5855",
  bright_red     = "#e8bbd0",
  bright_green   = "#3a3432",
  bright_yellow  = "#4a4543",
  bright_blue    = "#807d7c",
  bright_magenta = "#d6d5d4",
  bright_cyan    = "#cdab53",
  bright_white   = "#f7f7f7",

  bg = "#090300",
  fg = "#a5a2a2",
}

vim.cmd("hi clear")
vim.o.background = "dark"
vim.g.colors_name = "3024"

local function hi(group, opts)
  local parts = { "hi", group }
  if opts.fg then table.insert(parts, "guifg=" .. opts.fg) end
  if opts.bg then table.insert(parts, "guibg=" .. opts.bg) end
  if opts.sp then table.insert(parts, "guisp=" .. opts.sp) end
  local attrs = {}
  if opts.bold then table.insert(attrs, "bold") end
  if opts.italic then table.insert(attrs, "italic") end
  if opts.underline then table.insert(attrs, "underline") end
  if #attrs > 0 then
    table.insert(parts, "gui=" .. table.concat(attrs, ","))
  end
  vim.cmd(table.concat(parts, " "))
end

-- UI
hi("Normal",      { fg = colors.fg, bg = colors.bg })
hi("CursorLine",  { bg = colors.bright_black })
hi("CursorColumn",{ bg = colors.bright_black })
hi("LineNr",      { fg = colors.bright_black })
hi("CursorLineNr",{ fg = colors.yellow })
hi("Visual",      { bg = "#3c3b37" })  -- soft, readable selection
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

