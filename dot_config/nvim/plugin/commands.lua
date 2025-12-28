vim.api.nvim_create_user_command('ToggleFormat', function()
    vim.g.autoformat = not vim.g.autoformat
    vim.notify(string.format('%s formatting...', vim.g.autoformat and 'Enabling' or 'Disabling'), vim.log.levels.INFO)
end, { desc = 'Toggle conform.nvim auto-formatting', nargs = 0 })

vim.api.nvim_create_user_command('ToggleInlayHints', function()
    vim.g.inlay_hints = not vim.g.inlay_hints
    vim.notify(string.format('%s inlay hints...', vim.g.inlay_hints and 'Enabling' or 'Disabling'), vim.log.levels.INFO)

    local mode = vim.api.nvim_get_mode().mode
    local normal_or_visual = (mode == 'n' or mode == 'v')
    vim.lsp.inlay_hint.enable(vim.g.inlay_hints and normal_or_visual)
end, { desc = 'Toggle inlay hints', nargs = 0 })

vim.api.nvim_create_user_command('Todos', function()
    require('fzf-lua').grep { search = [[TODO:|todo!\(.*\)]], no_esc = true }
end, { desc = 'Grep TODOs', nargs = 0 })

vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd 'bel 10new'
    local buf = vim.api.nvim_get_current_buf()
    for name, value in pairs {
        filetype = 'scratch',
        buftype = 'nofile',
        bufhidden = 'wipe',
        swapfile = false,
        modifiable = true,
    } do
        vim.api.nvim_set_option_value(name, value, { buf = buf })
    end
end, { desc = 'Open a scratch buffer', nargs = 0 })

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

alias('chmod', 'Chmod')
alias('rm', 'Delete')

alias('json', '%!jq .')
