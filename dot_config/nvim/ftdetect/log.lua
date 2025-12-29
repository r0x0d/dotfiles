-- Filetype detection for log files
vim.filetype.add {
    -- Match by extension
    extension = {
        log = 'log',
        LOG = 'log',
    },
    -- Match by pattern (Lua patterns, not globs)
    pattern = {
        ['.*_log$'] = 'log',
        ['.*_LOG$'] = 'log',
        ['.*%.log%.[0-9]+$'] = 'log', -- rotated logs like app.log.1
    },
}
