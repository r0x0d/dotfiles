-- Lets us create custom lowercase user commands to overwrite builtins like 'ls' for actual useful features.
local function alias(name, ...)
  local args = { ... }
  vim.keymap.set('ca', name, function()
    if vim.fn.getcmdtype() == ':' and vim.fn.getcmdline():find('^' .. name) then
      return table.concat(args, ' ')
    end
    return name
  end, { noremap = true, expr = true, replace_keycodes = true })
end

alias('unstage', 'lua', 'package.loaded.gitsigns.reset_hunk()')
alias('stage', 'lua', 'package.loaded.gitsigns.stage_hunk()')
alias('blame', 'lua', 'package.loaded.gitsigns.blame_line { full = true }')

alias('debug', 'lua', 'package.loaded.dapui.toggle()')

alias('fix', 'lua', 'vim.lsp.buf.code_action()')
alias('fmt', 'lua', 'vim.lsp.buf.format()')
alias('rename', 'lua vim.lsp.buf.rename()')

alias('ls', 'Telescope buffers')
alias('lsp', 'Telescope find_files')

alias('chmod', 'Chmod')
alias('rm', 'Delete')

alias('todo', 'TodoTrouble')
alias('json', '%!jq .')
alias('lgrep', 'silent', 'lgrep')
alias('grep', 'silent', 'grep')
