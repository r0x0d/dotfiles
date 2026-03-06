vim.filetype.add {
    filename = {
        ['.eslintrc.json'] = 'jsonc',
    },
    pattern = {
        ['*Containerfile*'] = 'dockerfile',
        ['.*_log$'] = 'log',
        ['.*_LOG$'] = 'log',
        ['.*%.log%.[0-9]+$'] = 'log',
        ['*.bashrc'] = 'sh',
    },
    extension = {
        h = 'c',
        Containerfile = 'dockerfile',
        bashrc = 'sh',
        device = 'systemd',
        mount = 'systemd',
        nspawn = 'systemd',
        service = 'systemd',
        timer = 'systemd',
        ddl = 'sql',
        log = 'log',
        LOG = 'log',
        jinja2 = 'jinja',
        j2 = 'jinja',
    },
}
