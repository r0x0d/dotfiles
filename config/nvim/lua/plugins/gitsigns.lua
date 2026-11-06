local icons = require("config.icons")

require("gitsigns").setup({
  -- Reuse the shared icons so gutter signs match the statusline/diff glyphs.
  -- topdelete/changedelete reuse the plain variants (no distinct glyphs).
  signs = {
    add = { text = icons.git.added },
    change = { text = icons.git.changed },
    delete = { text = icons.git.removed },
    topdelete = { text = icons.git.removed },
    changedelete = { text = icons.git.changed },
  },
  -- Buffer-local maps: only exist in buffers gitsigns actually attaches to
  -- (tracked files), so they never shadow keys elsewhere.
  on_attach = function(buf)
    local gs = require("gitsigns")
    local function m(k, f, d) vim.keymap.set("n", k, f, { buffer = buf, desc = d }) end
    m("]h", function() gs.nav_hunk("next") end, "Next hunk")
    m("[h", function() gs.nav_hunk("prev") end, "Prev hunk")
    m("<leader>hs", gs.stage_hunk, "Stage hunk")
    m("<leader>hr", gs.reset_hunk, "Reset hunk")
    m("<leader>hp", gs.preview_hunk, "Preview hunk")
    m("<leader>hb", gs.blame_line, "Blame line")
  end,
})
