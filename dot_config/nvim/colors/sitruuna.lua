-- Based on the original https://github.com/eemed/sitruuna.vim/blob/master/colors/sitruuna.vim
-- A fresh lemon inspired colorscheme for Neovim

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.background = 'dark'
vim.g.colors_name = 'sitruuna'

-- Color palette
local colors = {
  lemon      = { gui = '#FAC03B', cterm = 220 },
  special    = { gui = '#ffb354', cterm = 215 },
  preproc    = { gui = '#a29bfe', cterm = 147 },
  func       = { gui = '#a3db81', cterm = 117 },
  foreground = { gui = '#d1d1d1', cterm = 188 },
  fg_alt     = { gui = '#a1a1a1', cterm = 145 },
  statusline = { gui = '#34373a', cterm = 137 },
  darker     = { gui = '#232627', cterm = 232 },
  background = { gui = '#232627', cterm = 233 },
  light_bg   = { gui = '#1d2023', cterm = 236 },
  lighter_bg = { gui = '#242629', cterm = 238 },
  comment    = { gui = '#5c6366', cterm = 244 },
  selection  = { gui = '#2D3032', cterm = 238 },
  string     = { gui = '#37ad82', cterm = 72 },
  type       = { gui = '#7398dd', cterm = 104 },
  constant   = { gui = '#ca70d6', cterm = 170 },
  error      = { gui = '#c15959', cterm = 131 },
  none       = { gui = 'NONE', cterm = 'NONE' },
}

-- Highlighting helper function
local function hl(group, fg, bg, attr, sp)
  local cmd = { 'hi', group }
  
  if fg then
    local color = colors[fg]
    if color then
      table.insert(cmd, 'guifg=' .. color.gui)
      table.insert(cmd, 'ctermfg=' .. color.cterm)
    end
  end
  
  if bg then
    local color = colors[bg]
    if color then
      table.insert(cmd, 'guibg=' .. color.gui)
      table.insert(cmd, 'ctermbg=' .. color.cterm)
    end
  end
  
  if attr then
    table.insert(cmd, 'gui=' .. attr)
    table.insert(cmd, 'cterm=' .. attr)
  end
  
  if sp then
    local color = colors[sp]
    if color then
      table.insert(cmd, 'guisp=' .. color.gui)
    end
  end
  
  vim.cmd(table.concat(cmd, ' '))
end

-- UI highlights
hl('Normal', 'foreground', 'background')
hl('NonText', 'comment', 'background')
hl('EndOfBuffer', 'lighter_bg')
hl('LineNr', 'comment', 'light_bg')
hl('FoldColumn', 'lighter_bg', 'darker')
hl('Folded', 'fg_alt', 'statusline')
hl('MatchParen', 'special', 'none', 'bold')
hl('SignColumn', 'lighter_bg', 'darker')
hl('Comment', 'comment', 'none')
hl('Conceal', 'error', 'none')
hl('Constant', 'constant', 'none')
hl('Error', 'error', 'none', 'none')
hl('Identifier', 'func', 'none')
hl('Ignore', 'comment', 'none')
hl('PreProc', 'preproc', 'none')
hl('Special', 'special', 'none')
hl('Statement', 'lemon', 'none', 'bold')
hl('String', 'string', 'none')
hl('Todo', 'background', 'string')
hl('Type', 'type', 'none', 'none')
hl('Underlined', 'func', 'none')
hl('Pmenu', 'foreground', 'light_bg')
hl('PmenuSbar', 'light_bg', 'light_bg')
hl('PmenuSel', 'background', 'lemon')
hl('PmenuThumb', 'func')
hl('ErrorMsg', 'error', 'none', 'none')
hl('ModeMsg', 'special', 'none')
hl('MoreMsg', 'func', 'none')
hl('Question', 'foreground', 'none')
hl('WarningMsg', 'lemon', 'none')
hl('TabLine', 'foreground', 'light_bg', 'none')
hl('TabLineFill', 'foreground', 'light_bg', 'none')
hl('TabLineSel', 'foreground', 'statusline', 'bold')
hl('Cursor', 'none', 'foreground')
hl('CursorColumn', 'none', 'light_bg')
hl('CursorLineNr', 'special', 'light_bg')
hl('CursorLine', 'none', 'light_bg', 'none')
hl('StatusLine', 'statusline', 'foreground')
hl('StatusLineNC', 'light_bg', 'comment')
hl('Visual', 'none', 'selection')
hl('VisualNOS', 'foreground', 'background')
hl('VertSplit', 'lighter_bg', 'lighter_bg')
hl('WildMenu', 'foreground', 'background')
hl('Function', 'func', 'none', 'none')
hl('SpecialKey', 'special', 'none')
hl('Title', 'lemon', 'none', 'bold')
hl('DiffAdd', 'string', 'none')
hl('DiffChange', 'lemon', 'none')
hl('DiffDelete', 'error', 'none')
hl('DiffText', 'func', 'none')
hl('Directory', 'lemon', 'none')
hl('debugPC', 'error', 'none')
hl('debugBreakpoint', 'error', 'none')
hl('ColorColumn', 'none', 'light_bg')
hl('Delimiter', 'none', 'none')
hl('Operator', 'func', 'none', 'none')
hl('htmlTagName', 'lemon', 'none', 'bold')
hl('htmlTag', 'foreground', 'none')
hl('htmlArg', 'func', 'none')
hl('IncSearch', 'special', 'background', 'reverse,bold')
hl('Search', 'special', 'background', 'reverse,bold')
hl('Substitute', 'special', 'background', 'reverse,bold')
hl('SpellBad', 'error', 'none', 'bold,underline')
hl('SpellCap', 'error', 'none', 'bold,underline')
hl('SpellLocal', 'special', 'none', 'bold,underline')
hl('SpellRare', 'special', 'none', 'bold,underline')

-- Link highlight groups
local links = {
  Terminal                 = 'Normal',
  Number                   = 'Constant',
  CursorIM                 = 'Cursor',
  Boolean                  = 'Constant',
  Character                = 'Constant',
  Conditional              = 'Statement',
  Debug                    = 'Special',
  Define                   = 'PreProc',
  Exception                = 'Statement',
  Float                    = 'Number',
  HelpCommand              = 'Statement',
  HelpExample              = 'Statement',
  Include                  = 'PreProc',
  Keyword                  = 'Statement',
  Label                    = 'Statement',
  Macro                    = 'PreProc',
  PreCondit                = 'PreProc',
  Repeat                   = 'Statement',
  SpecialChar              = 'Special',
  SpecialComment           = 'Special',
  StorageClass             = 'Statement',
  Structure                = 'Statement',
  Tag                      = 'Special',
  Typedef                  = 'Statement',
  htmlEndTag               = 'htmlTagName',
  htmlLink                 = 'Function',
  htmlSpecialTagName       = 'htmlTagName',
  htmlBold                 = 'Normal',
  htmlItalic               = 'Normal',
  xmlTag                   = 'Statement',
  xmlTagName               = 'Statement',
  xmlEndTag                = 'Statement',
  asciidocQuotedEmphasized = 'Preproc',
  diffBDiffer              = 'WarningMsg',
  diffCommon               = 'WarningMsg',
  diffDiffer               = 'WarningMsg',
  diffIdentical            = 'WarningMsg',
  diffIsA                  = 'WarningMsg',
  diffNoEOL                = 'WarningMsg',
  diffOnly                 = 'WarningMsg',
  diffRemoved              = 'DiffDelete',
  diffAdded                = 'DiffAdd',
  QuickFixLine             = 'Search',
  ConId                    = 'Type',
  -- Yaml
  yamlBlockMappingKey      = 'Statement',
  yamlFlowIndicator        = 'SpecialKey',
  -- Markdown
  markdownCode             = 'String',
  markdownCodeDelimiter    = 'String',
  markdownCodeBlock        = 'String',
  markdownHeadingDelimiter = 'Type',
  markdownLinkText         = 'Special',
  markdownItalic           = 'Preproc',
  -- CSS
  cssTagName               = 'SpecialKey',
  cssClassName             = 'Statement',
  cssDefinition            = 'Special',
  cssProp                  = 'Special',
  -- Fugitive
  fugitiveHash             = 'Constant',
  -- Python
  pythonBuiltin            = 'Constant',
  pythonImport             = 'PreProc',
  pythonInclude            = 'Special',
  pythonStatement          = 'Statement',
  pythonConditional        = 'Special',
  pythonRepeat             = 'Special',
  pythonException          = 'Error',
  pythonOperator           = 'Function',
  pythonDecorator          = 'Type',
  pythonDecoratorName      = 'Type',
  pythonFunction           = 'Function',
  pythonClass              = 'Type',
  -- JSX
  jsxComponentName         = 'Statement',
  jsxTagName               = 'Special',
  -- Neomake
  NeomakeErrorSign         = 'ErrorMsg',
  NeomakeWarningSign       = 'WarningMsg',
  NeomakeMessageSign       = 'WarningMsg',
  NeomakeInfoSign          = 'Type',
  NeomakeVirtualtextError  = 'ErrorMsg',
  NeomakeVirtualtextWarning = 'WarningMsg',
  NeomakeVirtualtextMessage = 'WarningMsg',
  NeomakeVirtualtextInfo   = 'Type',
}

for from, to in pairs(links) do
  vim.cmd('hi link ' .. from .. ' ' .. to)
end

-- FZF colors
if vim.g.sitruuna_fzf ~= 0 then
  vim.g.fzf_colors = {
    fg      = { 'fg', 'NormalFloat' },
    bg      = { 'bg', 'NormalFloat' },
    hl      = { 'fg', 'Keyword', 'Keyword' },
    ['fg+'] = { 'fg', 'Function' },
    ['bg+'] = { 'bg', 'NormalFloat' },
    ['hl+'] = { 'fg', 'Keyword' },
    info    = { 'fg', 'PreProc' },
    border  = { 'fg', 'Ignore' },
    prompt  = { 'fg', 'DiffAdded' },
    pointer = { 'fg', 'Function' },
    marker  = { 'fg', 'Keyword' },
    spinner = { 'fg', 'Label' },
    header  = { 'fg', 'Comment' },
  }
end

-- TreeSitter highlights (for better syntax highlighting)
if vim.fn.has('nvim-0.8') == 1 then
  local ts_highlights = {
    -- Python
    ['@keyword.import.python']        = { link = 'PreProc' },
    ['@keyword.repeat.python']        = { link = 'Special' },
    ['@keyword.conditional.python']   = { link = 'Special' },
    ['@keyword.exception.python']     = { link = 'Error' },
    ['@keyword.return.python']        = { link = 'Statement' },
    ['@module.python']                = { link = 'Type' },
    ['@variable.builtin.python']      = { link = 'Constant' },
    ['@function.builtin.python']      = { link = 'Constant' },
    ['@decorator.python']             = { link = 'Type' },
    
    -- General TreeSitter
    ['@keyword.import']               = { link = 'PreProc' },
    ['@keyword.repeat']               = { link = 'Special' },
    ['@keyword.conditional']          = { link = 'Special' },
    ['@keyword.exception']            = { link = 'Error' },
    ['@keyword.return']               = { link = 'Statement' },
    ['@module']                       = { link = 'Type' },
    ['@namespace']                    = { link = 'Type' },
    ['@variable.builtin']             = { link = 'Constant' },
    ['@function.builtin']             = { link = 'Constant' },
    ['@decorator']                    = { link = 'Type' },
    ['@operator']                     = { link = 'Function' },
  }
  
  for group, opts in pairs(ts_highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

-- Terminal colors
vim.g.terminal_color_0  = colors.background.gui
vim.g.terminal_color_8  = colors.lighter_bg.gui
vim.g.terminal_color_1  = colors.error.gui
vim.g.terminal_color_9  = colors.error.gui
vim.g.terminal_color_2  = colors.string.gui
vim.g.terminal_color_10 = colors.string.gui
vim.g.terminal_color_3  = colors.lemon.gui
vim.g.terminal_color_11 = colors.special.gui
vim.g.terminal_color_4  = colors.type.gui
vim.g.terminal_color_12 = colors.type.gui
vim.g.terminal_color_5  = colors.constant.gui
vim.g.terminal_color_13 = colors.preproc.gui
vim.g.terminal_color_6  = colors.func.gui
vim.g.terminal_color_14 = colors.func.gui
vim.g.terminal_color_7  = colors.comment.gui
vim.g.terminal_color_15 = colors.foreground.gui
