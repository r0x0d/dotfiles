-- File tree (nvim-tree.lua): a NERDTree-style sidebar over the whole
-- project, toggled with <C-n> (config/keymaps.lua) and only loaded then,
-- via the "filetree" group. oil ( - ) edits one directory; the tree shows
-- them all.

local M = {}

function M.setup()
  require("nvim-tree").setup({
    -- Keep the cursor on the file name, not the icons in front of it
    hijack_cursor = true,
    -- Reveal the file of the buffer you switch to. The ignore list keeps
    -- the many special buffers in this config (terminals, dap-ui, pickers,
    -- dashboard, ...) from jerking the tree around.
    update_focused_file = {
      enable = true,
      ignore_list = {
        "toggleterm", "terminal", "dap-repl", "dap-float",
        "dapui_scopes", "dapui_breakpoints", "dapui_stacks", "dapui_watches",
        "oil", "NvimTree", "TelescopePrompt", "starter", "taskmd",
        "trouble", "help", "qf",
      },
    },
    -- Fold runs of empty directories: docs/dev instead of docs + dev
    renderer = { group_empty = true },
  })
end

return M
