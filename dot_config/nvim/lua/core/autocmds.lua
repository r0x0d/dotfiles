local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Restore cursor position when reopening a file
autocmd("BufReadPost", {
    group = augroup("restore-cursor", { clear = true }),
    callback = function(event)
        local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(event.buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Equalize splits when terminal is resized
autocmd("VimResized", {
    group = augroup("resize-splits", { clear = true }),
    command = "tabdo wincmd =",
})
