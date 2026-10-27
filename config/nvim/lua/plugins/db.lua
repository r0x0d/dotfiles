-- runs before the dadbod plugins load: they read these globals
vim.g.db_ui_use_nerd_fonts = 0
vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod_ui"

-- vim-dadbod-completion (table/column names from the active connection) is a
-- plain omnifunc. This runs before the plugin loads, which is fine: the
-- function is autoloaded on first use.
local sql_fts = { "sql", "mysql", "plsql" }
vim.api.nvim_create_autocmd("FileType", {
  pattern = sql_fts,
  callback = function(ev) vim.bo[ev.buf].omnifunc = "vim_dadbod_completion#omni" end,
  desc = "SQL completion through vim-dadbod-completion",
})
if vim.tbl_contains(sql_fts, vim.bo.filetype) then
  vim.bo.omnifunc = "vim_dadbod_completion#omni"
end
