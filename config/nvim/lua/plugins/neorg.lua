-- Neorg: structured notes in .norg files, one workspace per project under
-- ~/Notes. Loaded on demand by the "neorg" group in config/groups.lua (the
-- first :Neorg command or .norg file).
--
-- Neorg 9 declares its dependencies as luarocks packages, but vim.pack has no
-- luarocks support, so they are installed as plain git plugins instead (see
-- config/pack.lua): pathlib.nvim, lua-utils.nvim, nui.nvim, nvim-nio.
--
-- The norg treesitter parsers also ship as luarocks packages. They cannot go
-- through nvim-treesitter's installer either: the norg parser has a C++
-- scanner and the tree-sitter CLI only compiles C scanners. parser.c must be
-- compiled as C (designated initializers) and scanner.cc as C++; the objects
-- are then linked with the C++ driver so the C++ runtime comes along. A
-- single `cc` link leaves __gxx_personality_v0 unresolved and the parser
-- cannot be dlopen'd. build_parsers() below runs when neorg is installed
-- or updated (PackChanged hook in config/pack.lua).

local M = {}

-- Parser revisions neorg itself pins (its rockspec). Bump these together
-- with the neorg version in config/pack.lua.
local PARSERS = {
  {
    name = "norg",
    repo = "https://github.com/nvim-neorg/tree-sitter-norg",
    rev = "aa1a1a7ded81a094cc3d5cb14bea6f34b86d8688", -- v0.2.4
    sources = { "src/parser.c", "src/scanner.cc" },
  },
  {
    name = "norg_meta",
    repo = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
    rev = "6f0510cc516a3af3396a682fbd6655486c2c9d2d", -- v0.1.0
    sources = { "src/parser.c" },
  },
}

local function parser_path(name)
  return vim.fs.joinpath(vim.fn.stdpath("data"), "site", "parser", name .. ".so")
end

local function parsers_present()
  return vim.uv.fs_stat(parser_path("norg")) and vim.uv.fs_stat(parser_path("norg_meta"))
end

--- Compiles the norg/norg_meta parsers into nvim-treesitter's parser
--- directory (on the default runtimepath). Synchronous; takes a few seconds.
---@return boolean ok
function M.build_parsers()
  if vim.fn.executable("git") ~= 1 or (vim.fn.executable("cc") ~= 1 and vim.fn.executable("gcc") ~= 1) then
    vim.notify("neorg: building the norg parsers needs git and a C compiler", vim.log.levels.ERROR)
    return false
  end
  local cc = vim.fn.executable("cc") == 1 and "cc" or "gcc"
  local cxx
  for _, candidate in ipairs({ "c++", "g++", "clang++" }) do
    if vim.fn.executable(candidate) == 1 then
      cxx = candidate
      break
    end
  end

  local cache = vim.fs.joinpath(vim.fn.stdpath("cache"), "neorg-parsers")
  vim.fn.mkdir(cache, "p")
  vim.fn.mkdir(vim.fs.dirname(parser_path("norg")), "p")

  for _, p in ipairs(PARSERS) do
    local src = vim.fs.joinpath(cache, p.name)
    vim.fn.delete(src, "rf")

    local res = vim.system({ "git", "clone", "--quiet", p.repo, src }):wait()
    if res.code == 0 then
      res = vim.system({ "git", "-C", src, "checkout", "--quiet", p.rev }):wait()
    end
    if res.code == 0 then
      -- Compile each source to an object, then link. parser.c stays C
      -- (designated initializers); scanner.cc is C++, and linking with the
      -- C++ driver pulls in the C++ runtime (see the comment up top).
      local objs, needs_cxx = {}, false
      for i, source in ipairs(p.sources) do
        local is_cxx = source:sub(-3) == ".cc" or source:sub(-4) == ".cpp" or source:sub(-4) == ".cxx"
        needs_cxx = needs_cxx or is_cxx
        if is_cxx and not cxx then
          vim.notify("neorg: building the " .. p.name .. " parser needs a C++ compiler", vim.log.levels.ERROR)
          return false
        end
        local obj = i .. ".o"
        res = vim.system({ is_cxx and cxx or cc, "-c", "-fPIC", "-I", "src", source, "-o", obj }, { cwd = src }):wait()
        if res.code ~= 0 then break end
        table.insert(objs, obj)
      end
      if res.code == 0 then
        local link = { needs_cxx and cxx or cc, "-shared" }
        vim.list_extend(link, objs)
        table.insert(link, "-o")
        table.insert(link, parser_path(p.name))
        res = vim.system(link, { cwd = src }):wait()
      end
    end
    if res.code ~= 0 then
      vim.notify(("neorg: building the %s parser failed:\n%s"):format(p.name, res.stderr), vim.log.levels.ERROR)
      return false
    end
  end

  vim.notify("neorg: norg parsers built")
  return true
end

--- Runs from the group setup, after the plugins are on the runtimepath.
function M.setup()
  if not parsers_present() then M.build_parsers() end

  require("neorg").setup({
    load = {
      ["core.defaults"] = {}, -- the standard module set (todo items, journal, ...)
      ["core.concealer"] = {}, -- render headings, lists and links while editing
      ["core.esupports.metagen"] = {
        config = { type = "empty" }, -- insert @document.meta into new notes
      },
      ["core.dirman"] = {
        config = {
          -- One workspace per project, all under ~/Notes. The directory (and
          -- its index.norg) is created on first switch. Add yours here.
          workspaces = {
            notes = "~/Notes", -- general notes (the default workspace)
            lightwell = "~/Notes/lightwell",
            upstream = "~/Notes/upstream",
          },
          default_workspace = "notes",
          index = "index.norg",
        },
      },
    },
  })
end

return M
