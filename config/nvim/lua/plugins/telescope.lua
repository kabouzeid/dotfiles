return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })
    vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>/", require("telescope.builtin").live_grep, { desc = "Search in Project" })
    vim.keymap.set("n", "<leader>?", require("telescope.builtin").commands, { desc = "Commands" })
    vim.keymap.set("n", "<leader>:", require("telescope.builtin").command_history, { desc = "Command History" })
    vim.keymap.set("n", "<leader>;", require("telescope.builtin").registers, { desc = "Registers" })
    vim.keymap.set("n", "<leader>s", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>S", require("telescope.builtin").lsp_workspace_symbols, { desc = "Workspace Symbols" })
    vim.keymap.set("n", "<leader>o", require("telescope.builtin").oldfiles, { desc = "Open Recent Files" })
    vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, { desc = "Buffers" })
  end,
}
