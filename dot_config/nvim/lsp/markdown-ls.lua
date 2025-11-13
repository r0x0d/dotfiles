-- Install with: npm i -g vscode-langservers-extracted

---@type vim.lsp.Config
return {
    cmd = { 'vscode-markdown-language-server', '--stdio' },
    filetypes = { 'markdown' },
    settings = {},
}
