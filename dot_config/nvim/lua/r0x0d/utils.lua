-- Utility functions for r0x0d's Neovim config
local M = {}

-- Safe require function that handles errors
function M.safe_require(module)
  local status_ok, module_required = pcall(require, module)
  if not status_ok then
    vim.notify(string.format("Error requiring '%s': %s", module, module_required), vim.log.levels.ERROR)
    return nil
  end
  return module_required
end

-- Create a keymap with sensible defaults
function M.keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Create an augroup with autocommands
function M.augroup(name, autocommands)
  local group = vim.api.nvim_create_augroup(name, { clear = true })
  for _, autocmd in ipairs(autocommands) do
    vim.api.nvim_create_autocmd(autocmd.event, {
      group = group,
      pattern = autocmd.pattern,
      callback = autocmd.callback,
      desc = autocmd.desc,
    })
  end
end

-- Check if a plugin is installed
function M.is_plugin_loaded(plugin_name)
  return vim.api.nvim_buf_is_loaded(0) and package.loaded[plugin_name] ~= nil
end

-- Get highlight attributes for a highlight group
function M.get_hl_attr(name, attribute)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  return hl[attribute] or 0
end

return M