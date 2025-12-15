-- Install with: sudo dnf install rpm-spec-language-server 

---@type vim.lsp.Config
return {
    cmd = { 'rpm_lsp_server', '--stdio' },
    filetypes = { 'spec' },
    settings = {},
}
