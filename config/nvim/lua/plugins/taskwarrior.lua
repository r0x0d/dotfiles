-- Taskwarrior (taskwarrior.nvim): edit the task database as a buffer (:Tw),
-- quick-capture, a telescope picker and a statusline segment. Loaded right
-- after startup by the "taskwarrior" group (config/groups.lua) rather than on
-- first use, so the statusline segment is always live.
--
-- Task keys live under <Space>T (capital T): the lowercase t* block belongs
-- to the neotest maps, and the plugin's own defaults (<Space>tt open,
-- <Space>tf filter, ...) would clobber them. (:TwFeedback has no key.)

local M = {}

function M.setup()
  require("taskwarrior").setup({
    open_key = "<leader>T", -- task buffer; <leader>tt is test-nearest
    capture_key = "<leader>Ta", -- quick-capture from any buffer
    filter_key = "<leader>Tf", -- the rest are buffer-local or pickers
    sort_key = "<leader>Ts",
    group_key = "<leader>Tg",
    context_key = "<leader>Tc",
    view_key = "<leader>Tv",
    report_key = "<leader>Tr",
    project_add_key = "<leader>Tp",
  })

  -- The statusline segment caches its `task export` for 15s; refresh it as
  -- soon as the plugin reloads a task buffer (after :w, :TwRefresh, ...).
  vim.api.nvim_create_autocmd("User", {
    pattern = "TaskwarriorRefresh",
    callback = function() require("taskwarrior.statusline").invalidate() end,
    desc = "taskwarrior.nvim: refresh the statusline cache",
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "taskmd",
    callback = function(ev) vim.bo[ev.buf].omnifunc = "v:lua.require'plugins.taskwarrior'.omnifunc" end,
    desc = "taskwarrior.nvim: complete project:, +tag and field names",
  })
  -- the buffer that triggered the load is already past its FileType event
  if vim.bo.filetype == "taskmd" then
    vim.bo.omnifunc = "v:lua.require'plugins.taskwarrior'.omnifunc"
  end
end

-- The plugin ships an nvim-cmp style source ("task") that completes project:,
-- +tags and field names. Its complete() is synchronous and only needs the text
-- before the cursor, so it can be called directly from an omnifunc.
local source
function M.omnifunc(findstart, _)
  local line = vim.api.nvim_get_current_line():sub(1, vim.fn.col(".") - 1)
  if findstart == 1 then
    -- word starts after the last space or ':' ("+tag" keeps its "+")
    return (line:match("^.*[:%s]()") or 1) - 1
  end
  source = source or require("taskwarrior.cmp").new()
  local words, seen = {}, {}
  source:complete({ context = { cursor_before_line = line } }, function(res)
    for _, it in ipairs(res.items or {}) do
      if not seen[it.label] then -- built-in field names also come back as UDAs
        seen[it.label] = true
        local icons = require("config.icons")
        table.insert(words, {
          word = it.label,
          abbr = icons.kind(it.kind) .. " " .. it.label,
          menu = "[task]",
        })
      end
    end
  end)
  return words
end

return M
