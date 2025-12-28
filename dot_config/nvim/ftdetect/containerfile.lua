vim.filetype.add({
	pattern = {
		-- Force Containerfiles to load as dockerfile filetype
		["*Containerfile*"] = "dockerfile",
	},
	extension = {
		Containerfile = "dockerfile",
	},
})
