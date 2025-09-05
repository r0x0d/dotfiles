local set = vim.opt_local

set.expandtab = false
set.tabstop = 4
set.shiftwidth = 4

vim.keymap.set('n', '<space>td', function()
  require('dap-go').debug_test()
end, { buffer = 0 })

local golang = vim.api.nvim_create_augroup('goformat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  group = golang,
  callback = function()
    require('go.format').goimport()
  end,
})
