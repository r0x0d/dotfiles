vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name ~= "nvim-treesitter" then return end
        if ev.data.kind == "delete" then return end
        if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
        vim.cmd("TSUpdate")
    end,
})

vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
})

local ensure_installed = {
    "python", "rust", "c_sharp", "gdscript",
    "lua", "vim", "vimdoc", "query",
    "markdown", "markdown_inline",
    "toml", "yaml", "json", "bash", "ini",
}

local installed = require("nvim-treesitter.config").get_installed()
local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(installed, lang)
end, ensure_installed)

if #missing > 0 then
    vim.schedule(function()
        vim.cmd("TSInstall " .. table.concat(missing, " "))
    end)
end

vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable treesitter highlighting",
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
