local group = vim.api.nvim_create_augroup("user", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  desc = "Restore last cursor position",
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "yaml", "lua", "json", "toml", "spec" },
  callback = function() vim.bo.shiftwidth = 2; vim.bo.tabstop = 2 end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  desc = "Start treesitter highlighting when a parser exists",
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local function m(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
    end
    m("gd", vim.lsp.buf.definition, "Definition")
    m("gr", vim.lsp.buf.references, "References")
    m("K", vim.lsp.buf.hover, "Hover")
    m("<leader>rn", vim.lsp.buf.rename, "Rename")
    m("<leader>ca", vim.lsp.buf.code_action, "Code action")
  end,
})

-- Keep :help tags for doc/myconfig.txt fresh (cheap, only touches this dir)
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    pcall(vim.cmd, "silent helptags " .. vim.fn.stdpath("config") .. "/doc")
  end,
})

-- Help ftplugin turns line numbers off; keep them (and the rulers) so columns
-- line up with the buffer you came from
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "help",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.wo.colorcolumn = "80,120"
  end,
})

-- Terminals: numbers and rulers are just noise
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.colorcolumn = ""
    vim.wo.signcolumn = "no"
  end,
})
