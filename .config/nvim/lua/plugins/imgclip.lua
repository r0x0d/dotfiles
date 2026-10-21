-- needs wl-paste/xclip on Linux, pngpaste on macOS
require("img-clip").setup({
  default = {
    dir_path = "assets/images",
    relative_to_current_file = true,
    prompt_for_file_name = true,
  },
  filetypes = { markdown = { url_encode_path = true, template = "![$CURSOR]($FILE_PATH)" } },
})
