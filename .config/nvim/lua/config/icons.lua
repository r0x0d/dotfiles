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

return M
