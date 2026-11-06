local t = require("telescope")
t.setup({})
-- Extensions are optional (fzf needs a built binary), hence pcall: telescope
-- must still work without them.
pcall(t.load_extension, "fzf")
pcall(t.load_extension, "ui-select")
pcall(t.load_extension, "task") -- taskwarrior.nvim picker (<Space>fT)
