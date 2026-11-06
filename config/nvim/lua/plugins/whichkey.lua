require("which-key").setup({
  -- spec only names the <leader> groups; individual maps carry their own desc
  preset = "helix",
  spec = {
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>h", group = "hunks" },
    { "<leader>d", group = "debug" },
    { "<leader>l", group = "lsp" },
    { "<leader>o", group = "open terminal" },
    { "<leader>s", group = "session" },
    { "<leader>t", group = "test" },
    { "<leader>x", group = "trouble" },
  },
})
