-- Single source of truth for the emoji theme.
local M = {}

-- Space cadet modes
M.modes = {
  n = { "🛸", "NORMAL" },
  no = { "🛸", "OP" },
  i = { "🚀", "INSERT" },
  v = { "🌌", "VISUAL" },
  V = { "🌌", "V-LINE" },
  ["\22"] = { "🌌", "V-BLOCK" },
  R = { "☄️", "REPLACE" },
  c = { "🛰️", "COMMAND" },
  t = { "🪐", "TERMINAL" },
}

-- Seasons
M.git = { added = "🌱", changed = "🍂", removed = "🔥" }

M.diagnostics = { error = "🚨", warn = "🚧", info = "🛰️", hint = "💡" }

M.lsp = {
  basedpyright = "🐍",
  ruff = "🧹",
  ["rust-analyzer"] = "🦀", -- name used by rustaceanvim
  rust_analyzer = "🦀",
  jsonls = "🧩",
  dockerls = "🐳",
  yamlls = "📄",
  taplo = "🧾",
  rpm_spec_ls = "📦",
  bashls = "🐚",
  lua_ls = "🌙",
}

-- Completion menu: mostly Nerd Font (codicon) glyphs, a few emojis.
-- Keyed by LSP CompletionItemKind name.
M.kinds = {
  Text = "\u{eb69}",
  Method = "\u{ea8c}",
  Function = "\u{ea8c}",
  Constructor = "\u{ea8c}",
  Field = "\u{eb5f}",
  Variable = "\u{ea88}",
  Class = "\u{eb5b}",
  Interface = "\u{eb61}",
  Module = "\u{ea8b}",
  Property = "\u{eb65}",
  Unit = "\u{ea96}",
  Value = "\u{ea95}",
  Enum = "\u{ea95}",
  Keyword = "🔑",
  Snippet = "✂️",
  Color = "🎨",
  File = "\u{eb60}",
  Reference = "\u{ea94}",
  Folder = "\u{ea83}",
  EnumMember = "\u{eb5e}",
  Constant = "\u{eb5d}",
  Struct = "\u{ea91}",
  Event = "⚡",
  Operator = "\u{eb64}",
  TypeParameter = "\u{ea92}",
}

-- Icon for a CompletionItemKind (number or name), "" when unknown
function M.kind(k)
  if type(k) == "number" then k = vim.lsp.protocol.CompletionItemKind[k] end
  return M.kinds[k] or ""
end

-- Taskwarrior statusline segment (config/statusline.lua)
M.task = "📋"

return M
