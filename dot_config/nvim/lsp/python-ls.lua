-- Install with: sudo dnf install pyright

---@type vim.lsp.Config
return {
    cmd = { 'pyright' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'uv.lock' },
    settings = {
        ['pyright'] = { },
    },
}