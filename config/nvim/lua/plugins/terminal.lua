require("toggleterm").setup({
  open_mapping = [[<C-\>]],
  -- Only toggleterm uses fish. 'shell' stays as-is because plugins and :!
  -- build POSIX-syntax commands that fish would mangle.
  shell = vim.fn.exepath("fish") ~= "" and vim.fn.exepath("fish") or vim.o.shell,
  -- float default: it hides over the code instead of resizing windows
  direction = "float",
  float_opts = { border = "rounded" },
  -- size only applies to split directions (float ignores it)
  size = function(term)
    if term.direction == "horizontal" then return 15 end
    if term.direction == "vertical" then return math.floor(vim.o.columns * 0.4) end
  end,
  shade_terminals = false,
  -- persist_mode = false: always re-enter in insert mode when reopening
  persist_mode = false,
})

local Terminal = require("toggleterm.terminal").Terminal

-- :Run <cmd> keeps a reusable terminal per command (cargo, mock, podman, ...)
local runners = {}
vim.api.nvim_create_user_command("Run", function(c)
  local cmd = c.args
  runners[cmd] = runners[cmd] or Terminal:new({
    cmd = cmd,
    direction = "horizontal",
    close_on_exit = false, -- keep output readable after the command ends
  })
  runners[cmd]:toggle()
end, { nargs = "+", complete = "shellcmd", desc = "Run a command in a toggleterm" })

local M = {}
-- single cached instance, so repeated <leader>og toggles the same lazygit;
-- hidden = true keeps it out of the <C-\> toggle-all cycle
local lazygit

function M.lazygit()
  if vim.fn.executable("lazygit") == 0 then
    return vim.notify("lazygit is not installed", vim.log.levels.WARN)
  end
  lazygit = lazygit or Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
  lazygit:toggle()
end

return M
