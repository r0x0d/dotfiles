require("neotest").setup({
  adapters = {
    -- justMyCode = false so debugging a test can step into library code
    require("neotest-python")({ runner = "pytest", dap = { justMyCode = false } }),
    -- rustaceanvim ships its own adapter (needs the rust group, see groups.lua)
    require("rustaceanvim.neotest"),
  },
})
