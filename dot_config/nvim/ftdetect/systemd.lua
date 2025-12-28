-- Taken from https://github.com/lithammer/nvim/blob/main/ftdetect/systemd.lua
vim.filetype.add({
	extension = {
		device = "systemd",
		mount = "systemd",
		nspawn = "systemd",
		service = "systemd",
		timer = "systemd",
	},
})
