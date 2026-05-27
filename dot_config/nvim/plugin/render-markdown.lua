local add_on_file_type = require('vim-pack').add_on_file_type

add_on_file_type('markdown', {
    {
        src = "MeanderingProgrammer/render-markdown.nvim",
        on_setup = function()
            local render_markdown = require("render-markdown")
            render_markdown.setup({
                enabled = true,
                render_modes = { "n", "c" },
            })
        end,
    }
})
