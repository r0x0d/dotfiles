local M = {}

-- Run fn right after startup finishes, keeping heavy setup off the startup path.
-- vim.schedule lets the first screen draw before fn runs.
function M.defer(fn)
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function() vim.schedule(fn) end,
  })
end

return M
