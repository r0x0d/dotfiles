vim.filetype.add {
  -- Force Containerfiles to load as dockerfile filetype
  pattern = {
    ['*Containerfile*'] = 'dockerfile',
  },
  extension = {
    h = 'c',
    Containerfile = 'dockerfile',
  },
}
