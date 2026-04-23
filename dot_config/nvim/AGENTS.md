# AGENTS.md - Neovim Configuration Guidelines

Guidelines for AI agents working on this Neovim configuration.

## Architecture

### Directory Structure

- `init.lua` — Entry point. Loads core modules, bootstraps lazy.nvim, generates helptags.
- `lua/core/options.lua` — `vim.opt` settings, `vim.g` globals, leader key, toggle state variables.
- `lua/core/keymaps.lua` — Non-plugin keymaps and toggle system functions.
- `lua/core/autocmds.lua` — Autocommands.
- `lua/plugins/*.lua` — Each file returns a lazy.nvim plugin spec table.
- `doc/nvimconfig.txt` — Custom help file (`:help nvimconfig`). Update when adding keybinds.

### Conventions

1. **One plugin spec per file** in `lua/plugins/`. Name the file after the plugin's function (e.g., `lsp.lua`, not `nvim-lspconfig.lua`).
2. **Plugin keymaps** belong in the plugin spec's `keys` or `on_attach`, NOT in `core/keymaps.lua`. Exception: toggle keymaps live in `core/keymaps.lua` because they cross-cut multiple plugins.
3. **No auto-activating behavior**. Completion is manual (`<C-Space>`). Autoformat is off by default. Linting is off by default.
4. **Toggle state** uses `vim.g.*` global variables. See `core/options.lua` for the canonical list.
5. **Lazy-loading is mandatory**. Use `keys`, `cmd`, `ft`, or `event` for every plugin. Only the colorscheme uses `lazy = false`.

### Style Rules

- Use `vim.keymap.set` with `desc` fields on every mapping.
- Prefer `opts = {}` table style over `config = function()` when possible.
- Keep Lua simple: no metatables, no complex abstractions.
- Comments explain why, not what.
- Use 4-space indentation in Lua files.

## Environment

- Runs inside Podman toolbox containers on Fedora Silverblue.
- Mason installs go to `~/.local/share/nvim/mason/` (persists across container rebuilds — home directory is bind-mounted).
- GDScript LSP requires Godot editor to be running (connects via TCP on port 6005).
- OmniSharp uses mason's standalone binary (no .NET SDK required).
- Clipboard uses `xsel`/`wl-copy` via `unnamedplus`.
- Terminal supports truecolor (`COLORTERM=truecolor`).
- Neovim 0.11+ — use modern APIs: `vim.diagnostic.enable()`, `vim.lsp.inlay_hint.enable()`, `vim.hl.on_yank()`.

## What NOT to Do

- Do not add autopairs, indent guides, or vim-sleuth plugins.
- Do not enable auto-completion popup (`autocomplete` must be `false` in cmp config).
- Do not enable format-on-save by default.
- Do not add plugins without clear justification.
- Do not use deprecated APIs (`vim.highlight.on_yank` → `vim.hl.on_yank`).
- Do not modify `core/keymaps.lua` toggle functions without understanding how `vim.g` state variables connect to conform, nvim-lint, and lualine.

## Adding a New Plugin

1. Create `lua/plugins/<name>.lua` returning a lazy.nvim spec.
2. Use lazy-loading (`keys`, `cmd`, `ft`, or `event`).
3. Add keymaps in the spec's `keys` field with descriptive `desc` strings.
4. Update `doc/nvimconfig.txt` with the new keybindings.
5. Update the plugin inventory below.
6. Test startup time: `nvim --startuptime /tmp/startup.log +qa`.

## Plugin Inventory

| File | Plugin(s) | Purpose |
|------|-----------|---------|
| colorscheme.lua | kanagawa.nvim | Theme |
| oil.lua | oil.nvim | File navigation |
| telescope.lua | telescope.nvim, fzf-native, ui-select | Fuzzy finder |
| treesitter.lua | nvim-treesitter | Syntax highlighting |
| lsp.lua | nvim-lspconfig, mason, mason-lspconfig | Language servers |
| cmp.lua | nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path, cmp_luasnip | Completion (manual) |
| snippets.lua | LuaSnip, friendly-snippets | Snippet engine + library |
| conform.lua | conform.nvim | Formatting (togglable) |
| lint.lua | nvim-lint | Linting (togglable) |
| gitsigns.lua | gitsigns.nvim | Git gutter signs |
| lualine.lua | lualine.nvim | Statusline |
| markdown.lua | render-markdown.nvim | Markdown rendering |
| dap.lua | nvim-dap, nvim-dap-ui, nvim-dap-python | Debugging |
| todo-comments.lua | todo-comments.nvim | TODO highlighting |

## Keybinding Prefixes

- `<leader>f` — Find (telescope)
- `<leader>t` — Toggle (feature toggles)
- `<leader>g` — Git (gitsigns)
- `<leader>c` — Code (formatting)
- `<leader>l` — LSP (diagnostics)
- `<leader>d` — Debug (DAP)
- `<leader>e` — Explorer (oil)
- `g` prefix — Go to (LSP navigation)
- `]`/`[` — Next/previous (hunks, diagnostics, todos)
