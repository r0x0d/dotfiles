require("neotest").setup({
  adapters = {
    require("neotest-python")({ runner = "pytest", dap = { justMyCode = false } }),
    require("rustaceanvim.neotest"),
  },
})
