local opt = vim.opt

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- Only set clipboard if not in SSH session
if not vim.env.SSH_CLIENT and not vim.env.SSH_TTY then
  opt.clipboard = 'unnamedplus'
end

-- Use OSC 52 for SSH sessions to support clipboard sync through terminal
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52 terminal clipboard',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
end