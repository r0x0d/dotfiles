local icons = require("config.icons")
local M = {}

function M.mode()
  local m = icons.modes[vim.fn.mode()] or icons.modes.n
  return m[1] .. " " .. m[2]
end

function M.git()
  local d = vim.b.gitsigns_status_dict
  if not d or not d.head then return "" end
  local parts = { " " .. d.head }
  if (d.added or 0) > 0 then table.insert(parts, icons.git.added .. d.added) end
  if (d.changed or 0) > 0 then table.insert(parts, icons.git.changed .. d.changed) end
  if (d.removed or 0) > 0 then table.insert(parts, icons.git.removed .. d.removed) end
  return table.concat(parts, " ")
end

function M.lsp()
  local out = {}
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(out, icons.lsp[c.name] or "⚙️")
  end
  return table.concat(out, "")
end

function M.diag()
  local sev = vim.diagnostic.severity
  local out = {}
  for key, s in pairs({ error = sev.ERROR, warn = sev.WARN, info = sev.INFO, hint = sev.HINT }) do
    local n = #vim.diagnostic.get(0, { severity = s })
    if n > 0 then table.insert(out, icons.diagnostics[key] .. n) end
  end
  return table.concat(out, " ")
end

_G.Statusline = M

vim.o.statusline = table.concat({
  " %{v:lua.Statusline.mode()}",
  "  %{v:lua.Statusline.git()}",
  "  %f %m%r",
  "%=",
  "%{v:lua.Statusline.diag()}  ",
  "%{v:lua.Statusline.lsp()}  ",
  "%y  %l:%c  %p%% ",
})
