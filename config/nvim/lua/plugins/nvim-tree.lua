return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      -- don't disable netrw because it's used by Neovim for downloading spell files
      disable_netrw = false,
      -- hijack netrw window on startup
      hijack_netrw = false,
      -- hijack the cursor in the tree to put it at the start of the filename
      hijack_cursor = true,
      -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
      update_cwd = true,
      -- show lsp diagnostics in the signcolumn
      diagnostics = {
        enable = true,
        icons = {
          hint = require("nvim-nonicons").get("comment"),
          info = require("nvim-nonicons").get("info"),
          warning = require("nvim-nonicons").get("alert"),
          error = require("nvim-nonicons").get("x-circle"),
        },
      },
      view = {
        side = "right",
      },
      renderer = {
        group_empty = true,
        add_trailing = true,
        icons = {
          glyphs = {
            default = require("nvim-nonicons").get("file"),
            symlink = require("nvim-nonicons").get("file-symlink"),
            git = {
              -- unstaged = require("nvim-nonicons").get("diff-modified"),
              -- staged = require("nvim-nonicons").get("check-circle"),
              -- unmerged = require("nvim-nonicons").get("git-merge"),
              -- renamed = require("nvim-nonicons").get("diff-renamed"),
              -- untracked = require("nvim-nonicons").get("diff-added"),
              -- deleted = require("nvim-nonicons").get("diff-removed"),
              -- ignored = require("nvim-nonicons").get("diff-ignored")
              unstaged = "M",
              staged = "S",
              unmerged = require("nvim-nonicons").get("git-merge"),
              renamed = "R",
              untracked = "U",
              deleted = "D",
              ignored = "I",
            },
            folder = {
              default = require("nvim-nonicons").get("file-directory"),
              open = require("nvim-nonicons").get("file-directory"),
              empty = require("nvim-nonicons").get("file-directory-outline"),
              empty_open = require("nvim-nonicons").get("file-directory-outline"),
              symlink = require("nvim-nonicons").get("file-submodule"),
              symlink_open = require("nvim-nonicons").get("file-submodule"),
            },
          },
        },
      },
    })

    -- -- disable nvim tree autocmds --- they are buggy
    -- vim.cmd("augroup NvimTreeView")
    -- vim.cmd("au!")
    -- vim.cmd("augroup END")

    vim.keymap.set("n", "<leader>t", require("nvim-tree.api").tree.toggle, { desc = "Toggle File Explorer" })
  end,
}
