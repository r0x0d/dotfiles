-- Plugin management with the built-in vim.pack (Neovim 0.12+).
-- Plugins live in ~/.local/share/nvim/site/pack/core/opt, revisions are pinned
-- in nvim-pack-lock.json (next to init.lua; commit it).
--   :PackUpdate  review and apply updates     :PackStatus  show state

-- Build steps. Must be registered BEFORE vim.pack.add() to also run on install.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then return end

    if name == "nvim-treesitter" then
      if not ev.data.active then vim.cmd.packadd(name) end
      pcall(vim.cmd, "TSUpdate")
    elseif name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    elseif name == "neorg" then
      -- Compile the norg/norg_meta treesitter parsers. The tree-sitter CLI
      -- cannot build the norg parser (C++ scanner), see plugins/neorg.lua.
      require("plugins.neorg").build_parsers()
    end
  end,
})

-- `lazy = true` plugins are installed but NOT put on the runtimepath here;
-- config/groups.lua loads them on demand through config/loader.lua.
local function gh(repo, version, lazy)
  return {
    src = "https://github.com/" .. repo,
    version = version,
    data = { lazy = lazy == true },
  }
end
local L = true -- readability: gh("x/y", nil, L)

vim.pack.add({
  -- always loaded
  gh("nvim-tree/nvim-web-devicons"),
  gh("folke/tokyonight.nvim"),
  gh("nvim-treesitter/nvim-treesitter", "main"),
  gh("stevearc/oil.nvim"),
  gh("mason-org/mason.nvim"),

  -- libs, pulled in by the groups that need them
  gh("nvim-lua/plenary.nvim", nil, L),
  gh("nvim-neotest/nvim-nio", nil, L),
  gh("b0o/schemastore.nvim", nil, L),

  -- on demand (see config/groups.lua for the triggers)
  gh("nvim-tree/nvim-tree.lua", vim.version.range("1"), L),
  gh("nvim-treesitter/nvim-treesitter-context", nil, L),
  gh("nvim-telescope/telescope.nvim", nil, L),
  gh("nvim-telescope/telescope-fzf-native.nvim", nil, L),
  gh("nvim-telescope/telescope-ui-select.nvim", nil, L),
  gh("folke/which-key.nvim", nil, L),
  gh("lewis6991/gitsigns.nvim", nil, L),
  gh("sindrets/diffview.nvim", nil, L),
  gh("pwntester/octo.nvim", nil, L),
  gh("WhoIsSethDaniel/mason-tool-installer.nvim", nil, L),
  gh("mfussenegger/nvim-dap", nil, L),
  gh("rcarriga/nvim-dap-ui", nil, L),
  gh("theHamsta/nvim-dap-virtual-text", nil, L),
  gh("mfussenegger/nvim-dap-python", nil, L),
  gh("mrcjkb/rustaceanvim", nil, L),
  gh("nvim-neotest/neotest", nil, L),
  gh("nvim-neotest/neotest-python", nil, L),
  gh("tpope/vim-sleuth", nil, L),
  gh("folke/trouble.nvim", nil, L),
  gh("folke/todo-comments.nvim", nil, L),
  gh("stevearc/conform.nvim", nil, L),
  gh("MeanderingProgrammer/render-markdown.nvim", nil, L),
  gh("HakonHarnes/img-clip.nvim", nil, L),
  gh("tpope/vim-dadbod", nil, L),
  gh("kristijanhusak/vim-dadbod-ui", nil, L),
  gh("kristijanhusak/vim-dadbod-completion", nil, L),
  gh("akinsho/toggleterm.nvim", vim.version.range("*"), L),
  gh("folke/persistence.nvim", nil, L),
  gh("echasnovski/mini.starter", nil, L),

  -- notes (neorg): the "neorg" group loads these on the first :Neorg command
  -- or .norg file. Pinned to tags like the rest (neorg: latest 9.x; the
  -- others: the versions neorg's rockspec declares, as vim.pack can't do
  -- luarocks). Parsers are compiled by the PackChanged hook below.
  gh("nvim-neorg/neorg", vim.version.range("9"), L),
  gh("pysan3/pathlib.nvim", vim.version.range("~2.2"), L),
  gh("nvim-neorg/lua-utils.nvim", vim.version.range("1.0.2"), L),
  gh("MunifTanjim/nui.nvim", vim.version.range("0.3"), L),

  -- tasks (taskwarrior.nvim); loaded right after startup by the "taskwarrior"
  -- group so the statusline segment works.
  gh("MattHandzel/taskwarrior.nvim", vim.version.range("1"), L),
}, {
  confirm = false,
  load = function(plug)
    local name = plug.spec.name
    if plug.spec.data and plug.spec.data.lazy then return end
    -- same as vim.pack's default during init.lua (:packadd!)
    vim.cmd("packadd! " .. name)
    require("config.loader").on_rtp[name] = true
  end,
})
