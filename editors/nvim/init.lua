-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_create_autocmd('UILeave', {
  callback = function()
    io.write '\027]111\027\\'
  end,
})

-- [[ Setting options ]]
require 'r0x0d.options'

-- [[ Basic Keymaps ]]
require 'r0x0d.keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'r0x0d.lazy-bootstrap'

-- [[ Set up some aliases ]]
require 'r0x0d.aliases'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
