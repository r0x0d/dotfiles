-- needs wl-paste/xclip on Linux, pngpaste on macOS
require("img-clip").setup({
  default = {
    -- relative_to_current_file keeps images next to the note, so a blog/repo
    -- stays portable when moved
    dir_path = "assets/images",
    relative_to_current_file = true,
    prompt_for_file_name = true,
  },
  -- url_encode_path: file names with spaces still form a valid markdown link
  filetypes = { markdown = { url_encode_path = true, template = "![$CURSOR]($FILE_PATH)" } },
})
