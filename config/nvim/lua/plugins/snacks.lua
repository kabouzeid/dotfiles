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
      },
      icons = {
        files = {
          dir = require("nvim-nonicons").get("file-directory") .. " ",
          dir_open = require("nvim-nonicons").get("file-directory") .. " ",
          file = require("nvim-nonicons").get("file") .. " ",
        },
        tree = {
          vertical = "  ",
          middle   = "  ",
          last     = "  ",
        },
      },
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
        }
      }
    },
  },
  keys = {
    { "<leader>g", function() Snacks.lazygit.open() end,                 desc = "LazyGit" },
    { "<leader>f", function() Snacks.picker.files() end,                 desc = "Find Files" },
    { "<leader>/", function() Snacks.picker.grep() end,                  desc = "Search in Project" },
    { "<leader>?", function() Snacks.picker.commands() end,              desc = "Commands" },
    { "<leader>:", function() Snacks.picker.command_history() end,       desc = "Command History" },
    { "<leader>;", function() Snacks.picker.registers() end,             desc = "Registers" },
    { "<leader>s", function() Snacks.picker.lsp_symbols() end,           desc = "Document Symbols" },
    { "<leader>S", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
    { "<leader>o", function() Snacks.picker.recent() end,                desc = "Open Recent Files" },
    { "<leader>b", function() Snacks.picker.buffers() end,               desc = "Buffers" },
    { "<leader>t", function() Snacks.explorer() end,                     desc = "File Explorer" },
    { "<leader>d", function() Snacks.picker.diagnostics_buffer() end,    desc = "Diagnostics Buffer" },
    { "<leader>D", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
    { "<C-\\>",    function() Snacks.terminal.toggle() end,              desc = "Toggle Terminal",   mode = { "n", "t" } },
  }
}
