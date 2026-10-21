require("blink.cmp").setup({
  keymap = { preset = "default" }, -- <C-space> open, <C-y> accept, <C-n>/<C-p> select
  appearance = { nerd_font_variant = "mono" },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = { sql = { "dadbod", "snippets", "buffer" } },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
    },
  },
  -- Falls back to the Lua matcher (with a warning) if the Rust lib isn't built
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
})
