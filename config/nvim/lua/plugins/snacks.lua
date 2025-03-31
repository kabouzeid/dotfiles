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
    { "<leader>g", function() Snacks.lazygit.open() end, desc = "LazyGit" },
    { "<leader>f", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Search in Project" },
    { "<leader>?", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>;", function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>s", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols" },
    { "<leader>S", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
    { "<leader>o", function() Snacks.picker.recent() end, desc = "Open Recent Files" },
    { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
  }
}
