local function short(path) return vim.fn.fnamemodify(path, ":~") end

-- Unique git roots of recently opened files
local function project_roots(limit)
  local seen, roots = {}, {}
  for _, f in ipairs(vim.v.oldfiles) do
    if vim.uv.fs_stat(f) then
      local root = vim.fs.root(f, ".git")
      if root and not seen[root] then
        seen[root] = true
        table.insert(roots, root)
        if #roots >= limit then break end
      end
    end
  end
  return roots
end

local function session_file_for(dir)
  local name = dir:gsub("[\\/:]+", "%%")
  local dirpath = vim.fn.stdpath("state") .. "/sessions/"
  for _, f in ipairs({ dirpath .. name .. ".vim" }) do
    if vim.fn.filereadable(f) == 1 then return f end
  end
end

local function projects_section()
  local items = {}
  for _, root in ipairs(project_roots(5)) do
    table.insert(items, {
      name = short(root),
      section = "Projects",
      action = function()
        vim.cmd.cd(vim.fn.fnameescape(root))
        local sess = session_file_for(root)
        if sess then
          vim.cmd("silent! source " .. vim.fn.fnameescape(sess))
        else
          vim.cmd("Telescope find_files")
        end
      end,
    })
  end
  return items
end

local function sessions_section()
  local ok, persistence = pcall(require, "persistence")
  if not ok then return {} end
  local items = {}
  for i, file in ipairs(persistence.list()) do
    if i > 5 then break end
    local base = vim.fn.fnamemodify(file, ":t:r")
    local dir, branch = base:match("^(.-)%%%%(.*)$")
    dir = (dir or base):gsub("%%", "/")
    local label = short(dir) .. (branch and ("  (" .. branch:gsub("%%", "/") .. ")") or "")
    table.insert(items, {
      name = label,
      section = "Sessions",
      action = function() vim.cmd("silent! source " .. vim.fn.fnameescape(file)) end,
    })
  end
  return items
end

local function recent_section()
  local cwd = vim.fn.getcwd()
  local in_repo = vim.fs.root(cwd, ".git") ~= nil
  local items = require("mini.starter").sections.recent_files(6, in_repo, not in_repo)()
  -- mini.starter returns a placeholder item when nothing matches; hide the section
  if #items == 1 and items[1].name:match("^There are no") then return {} end
  return items
end

local function git_status()
  local cwd = vim.fn.getcwd()
  if not vim.fs.root(cwd, ".git") then return nil end
  local function git(args)
    local r = vim.system(vim.list_extend({ "git" }, args), { text = true, cwd = cwd }):wait(500)
    return r.code == 0 and vim.trim(r.stdout) or nil
  end
  local branch = git({ "branch", "--show-current" })
  local porcelain = git({ "status", "--porcelain" })
  if not branch then return nil end
  local dirty = 0
  if porcelain and porcelain ~= "" then dirty = #vim.split(porcelain, "\n") end
  return ("🌿 %s%s"):format(branch, dirty > 0 and ("  🍂 " .. dirty .. " changed") or "  🌱 clean")
end

local function footer()
  local parts = { ("🛸 nvim %s"):format(tostring(vim.version())) }
  local okv, plugs = pcall(vim.pack.get, nil, { info = false })
  if okv then
    local rtp, loaded = {}, 0
    for _, r in ipairs(vim.api.nvim_list_runtime_paths()) do rtp[r] = true end
    for _, p in ipairs(plugs) do
      if rtp[p.path] then loaded = loaded + 1 end
    end
    table.insert(parts, ("📦 %d/%d plugins loaded"):format(loaded, #plugs))
  end
  if vim.g.startup_ms then
    table.insert(parts, ("⚡ %.0fms to UI"):format(vim.g.startup_ms))
  end
  local okp, persistence = pcall(require, "persistence")
  if okp then
    local n = #persistence.list()
    table.insert(parts, ("🗂️ %d session%s"):format(n, n == 1 and "" or "s"))
  end
  table.insert(parts, ("🕘 %d recent files"):format(#vim.v.oldfiles))
  local lines = { table.concat(parts, "   ") }
  local g = git_status()
  if g then table.insert(lines, g) end
  return table.concat(lines, "\n")
end

local function header()
  return table.concat({
    "🛸  N E O V I M",
    "",
    short(vim.fn.getcwd()) .. "   ·   " .. os.date("%A, %d %B %Y"),
  }, "\n")
end

local starter = require("mini.starter")
starter.setup({
  header = header,
  footer = footer,
  evaluate_single = true,
  -- No "-": it must stay free for oil's "go to parent directory" mapping
  query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
  items = {
    sessions_section,
    projects_section,
    recent_section,
    {
      { name = "Find file", action = "Telescope find_files", section = "Actions" },
      { name = "Grep", action = "Telescope live_grep", section = "Actions" },
      { name = "Explorer", action = "Oil", section = "Actions" },
      { name = "New file", action = "enew | startinsert", section = "Actions" },
      { name = "Update plugins", action = "PackUpdate", section = "Actions" },
      { name = "Mason", action = "Mason", section = "Actions" },
      { name = "Help cheatsheet", action = "help myconfig", section = "Actions" },
      { name = "Quit", action = "qa", section = "Actions" },
    },
  },
  content_hooks = {
    starter.gen_hook.adding_bullet("» "),
    starter.gen_hook.indexing("all", { "Actions" }),
    starter.gen_hook.aligning("center", "center"),
  },
})

-- Time-to-UI is only known once the UI is up, so redraw the footer then
vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    vim.g.startup_ms = (vim.uv.hrtime() - vim.g.nvim_start) / 1e6
    if vim.bo.filetype == "ministarter" then starter.refresh() end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ministarter",
  callback = function()
    vim.wo.number, vim.wo.relativenumber = false, false
    vim.wo.colorcolumn, vim.wo.cursorline = "", false
    vim.wo.signcolumn = "no"
  end,
})
