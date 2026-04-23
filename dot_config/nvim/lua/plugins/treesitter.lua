return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local ensure = {
            "python", "rust", "c_sharp", "gdscript",
            "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline",
            "toml", "yaml", "json", "bash",
        }

        local installed = require("nvim-treesitter").get_installed()
        local to_install = vim.tbl_filter(function(lang)
            return not vim.tbl_contains(installed, lang)
        end, ensure)

        if #to_install > 0 then
            vim.cmd("TSInstall " .. table.concat(to_install, " "))
        end
    end,
}
