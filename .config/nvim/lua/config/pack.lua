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
    elseif name == "blink.cmp" then
      -- Compile the Rust fuzzy matcher. Fedora ships stable rust only, hence
      -- RUSTC_BOOTSTRAP. Needs blink.lib on the runtimepath.
      pcall(vim.cmd.packadd, "blink.lib")
      pcall(vim.cmd.packadd, name)
      vim.env.RUSTC_BOOTSTRAP = "1"
      local ok, err = pcall(function() require("blink.cmp").build():wait(600000) end)
      if not ok then vim.notify("blink.cmp build failed: " .. tostring(err), vim.log.levels.WARN) end
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
  gh("saghen/blink.lib", nil, L),

  -- on demand (see config/groups.lua for the triggers)
  gh("nvim-treesitter/nvim-treesitter-context", nil, L),
  gh("nvim-telescope/telescope.nvim", nil, L),
  gh("nvim-telescope/telescope-fzf-native.nvim", nil, L),
  gh("nvim-telescope/telescope-ui-select.nvim", nil, L),
  gh("folke/which-key.nvim", nil, L),
  gh("lewis6991/gitsigns.nvim", nil, L),
  gh("sindrets/diffview.nvim", nil, L),
  gh("pwntester/octo.nvim", nil, L),
  gh("saghen/blink.cmp", nil, L),
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
