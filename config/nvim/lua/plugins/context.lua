-- Cap the pinned header at 3 lines; multiline_threshold = 1 collapses long
-- multi-line signatures to one line so it never eats the screen.
require("treesitter-context").setup({ max_lines = 3, multiline_threshold = 1 })
