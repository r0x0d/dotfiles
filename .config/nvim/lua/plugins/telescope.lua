local t = require("telescope")
t.setup({})
pcall(t.load_extension, "fzf")
pcall(t.load_extension, "ui-select")
