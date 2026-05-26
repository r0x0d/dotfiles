vim.pack.add({
    "https://github.com/fei6409/log-highlight.nvim",
}, { load = function() end })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "log",
    once = true,
    callback = function()
        vim.cmd.packadd("log-highlight.nvim")
        require("log-highlight").setup({})
    end,
})
