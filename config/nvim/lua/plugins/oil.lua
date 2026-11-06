-- oil picks up devicons itself if set up; pcall because it is optional and
-- must not break directory browsing when absent
pcall(function() require("nvim-web-devicons").setup() end)
-- show_hidden: dotfiles matter in a dotfiles/config workflow
require("oil").setup({ view_options = { show_hidden = true } })
