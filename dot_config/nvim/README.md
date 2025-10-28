# r0x0d's Neovim Configuration

This is my Neovim configuration, designed to provide a modern, efficient, and feature-rich editing experience.

## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration file
├── .stylua.toml             # Lua code formatter config
├── lazy-lock.json           # Plugin lock file (auto-generated)
├── plugin/                  # Core Neovim settings (keymaps, options, etc.)
├── lua/r0x0d/              # Custom Lua modules
│   ├── utils.lua           # Utility functions
│   └── icons.lua           # Icon definitions
│   └── plugins/            # Plugin configurations, organized by category:
│       ├── ui/             # UI-related plugins (lualine, oil, etc.)
│       ├── completion/     # Completion and snippets (blink, luasnip, etc.)
│       ├── lsp/            # LSP and treesitter configurations
│       ├── git/            # Git-related plugins (gitsigns, gitlinker)
│       └── utility/        # Various utility plugins (telescope, todo-comments, etc.)
├── colors/                 # Custom color schemes
├── after/                  # FileTypePlugin configurations
└── snippets/               # Snippet files
```

## 🚀 Features

- **Modular Architecture**: Plugins are organized into categories for easier maintenance
- **Built-in LSP**: Language Server Protocol support with `mason.nvim` for easy installation
- **Advanced Completion**: Powered by `blink.cmp` for fast and smart completions
- **Git Integration**: Git signs, blame, and linking directly from Neovim
- **File Management**: With `oil.nvim` for a vim-like file browser
- **Treesitter**: Enhanced syntax highlighting and text objects
- **Debugging**: Built-in DAP (Debug Adapter Protocol) support
- **Testing**: Integrated test runner with `neotest`

## ⚙️ Installation

1. Make sure you have Neovim 0.9+ installed
2. Backup your current config: `mv ~/.config/nvim ~/.config/nvim.backup`
3. Clone this repository: `git clone <repository-url> ~/.config/nvim`
4. Start Neovim: `nvim`
5. Plugins will be automatically installed on first startup

## 🛠️ Customization

To modify the configuration:

1. UI settings are in `plugin/options.lua` and `plugin/keymaps.lua`
2. Plugin configurations are in `lua/r0x0d/plugins/` by category
3. Custom functions are in `lua/r0x0d/utils.lua`
4. Icons can be customized in `lua/r0x0d/icons.lua`

## 🔧 Key Mappings

- `<Space>` - Leader key
- `<Space> + e` - Toggle file explorer (Neotree)
- `<Space> + f` - Find files with Telescope
- `<Space> + g` - Git operations
- `<Space> + l` - LSP operations
- `<Ctrl>+h/j/k/l` - Navigate between splits

## 📦 Plugin Categories

### UI
- Status line and tabline with `lualine`
- File explorer with `oil.nvim`
- Appearance with `which-key`, `trouble.nvim`

### Completion & Snippets
- Completion engine with `blink.cmp`
- Snippet engine with `luasnip`
- Auto-closing of pairs with `autopairs`

### LSP & Development
- LSP configuration with `lspconfig`
- Syntax highlighting with `treesitter`
- Testing framework with `neotest`

### Git
- Git signs in the gutter with `gitsigns`
- Link to Git hosting with `gitlinker`

### Utilities
- Fuzzy finding with `telescope`
- Note-taking with `todo-comments`
- Debugging with `dap`

## 💡 Tips

- Run `:Lazy` to manage plugins
- Run `:Mason` to manage LSP servers, linters, and formatters
- Use `:checkhealth` to verify configuration
- Check `:help` for any command or setting

## 🤝 Contributing

Feel free to fork and modify this configuration to suit your needs. If you find issues or want to suggest improvements, please open an issue or submit a pull request.