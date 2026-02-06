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
    dashed_bar = '┊',
    search = '',
    vertical_bar = '│',
    project = '',
    venv = '',
    bug = '',
    lines = '',
    file_size = '󰙴',
    tree = '',
    lazy = '💤',
    formatting = '󰉼',
    no_formatting = '󰉾',
}

--- LSP/Language icons for status line (fallback when nvim-web-devicons unavailable).
M.languages = {
    lua = '',
    python = '',
    rust = '',
    c = '',
    json = '',
    yaml = '',
    markdown = '',
    bash = '',
    docker = '',
    ruby = '',
    csharp = '󰌛',
    zig = '',
    default = '',
    none = '',
}

--- Mapping from LSP server names to language keys (only servers in lsp/).
M.lsp_to_language = {
    lua_ls = 'lua',
    python_ls = 'python',
    ruff_ls = 'python',
    rust_ls = 'rust',
    clangd_ls = 'c',
    json_ls = 'json',
    yaml_ls = 'yaml',
    markdown_ls = 'markdown',
    bash_ls = 'bash',
    docker_ls = 'docker',
    ruby_ls = 'ruby',
    csharp_ls = 'csharp',
    zig_ls = 'zig',
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

