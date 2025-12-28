local opt = vim.opt

opt.clipboard = "unnamedplus"

-- Use OSC 52 for SSH sessions to support clipboard sync through terminal
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
	vim.g.clipboard = {
		name = "OSC 52 terminal clipboard",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
		},
	}
end

