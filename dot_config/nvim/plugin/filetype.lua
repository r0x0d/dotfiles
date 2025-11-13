vim.filetype.add {
  filename = {
    ['.eslintrc.json'] = 'jsonc',
  },
  -- Force Containerfiles to load as dockerfile filetype
  pattern = {
    ['*Containerfile*'] = 'dockerfile',
  },
  extension = {
    h = 'c',
    Containerfile = 'dockerfile',
    bashrc = 'sh',
  },
  -- Borrowed from LazyVim. Mark huge files to disable features later.
  ['.*'] = function(path, bufnr)
    return vim.bo[bufnr]
      and vim.bo[bufnr].filetype ~= 'bigfile'
      and path
      and vim.fn.getfsize(path) > (1024 * 500) -- 500 KB
      and 'bigfile'
      or nil
  end,
}
