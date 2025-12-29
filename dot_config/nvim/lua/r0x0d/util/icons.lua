-- Icons used throughout the configuration

local M = {}

--- Diagnostic severities.
M.diagnostics = {
    ERROR = '',
    WARN = '',
    HINT = '',
    INFO = '',
    DONE = '',
}

--- For folding.
M.arrows = {
    right = '',
    left = '',
    up = '',
    down = '',
}

--- LSP symbol kinds.
M.symbol_kinds = {
    Array = '󰅪',
    Class = '',
    Color = '󰏘',
    Constant = '󰏿',
    Constructor = '',
    Enum = '',
    EnumMember = '',
    Event = '',
    Field = '󰜢',
    File = '󰈙',
    Folder = '󰉋',
    FolderOpen = '󰝰',
    Function = '󰆧',
    Interface = '',
    Keyword = '󰌋',
    Method = '󰆧',
    Module = '',
    Operator = '󰆕',
    Property = '󰜢',
    Reference = '󰈇',
    Snippet = '',
    Struct = '',
    Text = '',
    TypeParameter = '',
    Unit = '',
    Value = '',
    Variable = '󰀫',
}

--- Shared icons that don't really fit into a category.
M.misc = {
    bug = '',
    dashed_bar = '┊',
    ellipsis = '…',
    git = '',
    palette = '󰏘',
    robot = '󰚩',
    search = '',
    terminal = '',
    toolbox = '󰦬',
    vertical_bar = '│',
}

--- LSP/Language emojis for status line.
M.languages = {
    lua = '🌙',
    python = '🐍',
    typescript = '📘',
    rust = '🦀',
    go = '🐹',
    c = '🔧',
    java = '☕',
    html = '🌐',
    css = '🎨',
    json = '📋',
    yaml = '📄',
    markdown = '📄',
    bash = '🐚',
    docker = '🐳',
    ruby = '💎',
    csharp = '#️⃣',
    default = '🔌',
    none = '⚠️',
}

--- Mapping from LSP server names to language keys.
M.lsp_to_language = {
    lua_ls = 'lua',
    python_ls = 'python',
    ruff_ls = 'python',
    ts_ls = 'typescript',
    tsserver = 'typescript',
    rust_analyzer = 'rust',
    gopls = 'go',
    clangd = 'c',
    jdtls = 'java',
    html = 'html',
    cssls = 'css',
    tailwindcss = 'css',
    json_ls = 'json',
    yaml_ls = 'yaml',
    markdown_ls = 'markdown',
    bash_ls = 'bash',
    docker_ls = 'docker',
    ruby_ls = 'ruby',
    csharp_ls = 'csharp',
    omnisharp = 'csharp',
    emmet_ls = 'html',
    eslint = 'typescript',
    phpactor = 'default',
}

--- DAP (debugger) icons.
M.dap = {
    expanded = '▾',
    collapsed = '▸',
    current_frame = '*',
    controls = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
    },
}

--- UI elements for pickers/prompts.
M.ui = {
    prompt = ' ',
    selection = ' ',
    entry = ' ',
}

return M

