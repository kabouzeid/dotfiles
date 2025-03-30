return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          }
        },
      }
    },
  },
  keys = {
    { "<leader>g", function() Snacks.lazygit.open() end, desc = "LazyGit" }
  }
}
