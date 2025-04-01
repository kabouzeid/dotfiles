return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitsigns").setup()
  end,
  keys = {
    { "<leader>hs", function() require('gitsigns').stage_hunk() end,                desc = "Stage hunk",     mode = { "n", "v" } },
    { "<leader>hr", function() require('gitsigns').reset_hunk() end,                desc = "Reset hunk",     mode = { "n", "v" } },
    { "<leader>hu", function() require('gitsigns').undo_stage_hunk() end,           desc = "Undo stage hunk" },
    { "<leader>hS", function() require('gitsigns').stage_buffer() end,              desc = "Stage buffer" },
    { "<leader>hR", function() require('gitsigns').reset_buffer() end,              desc = "Reset buffer" },
    { "<leader>hp", function() require('gitsigns').preview_hunk() end,              desc = "Preview hunk" },
    { "<leader>hb", function() require('gitsigns').blame_line({ full = true }) end, desc = "Blame line" },
    { "<leader>hd", function() require('gitsigns').diffthis() end,                  desc = "Diff this" },
    { "<leader>hD", function() require('gitsigns').diffthis("~") end,               desc = "Diff this ~" },
    { "ih",         function() require("gitsigns").select_hunk() end,               desc = "In hunk",        mode = { "o", "x" } },
    {
      "]c",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require('gitsigns').nav_hunk('next')
        end)
        return "<Ignore>"
      end,
      expr = true,
      desc = "Next hunk"
    },
    {
      "[c",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require('gitsigns').nav_hunk('prev')
        end)
        return "<Ignore>"
      end,
      expr = true,
      desc = "Prev hunk"
    },
  }
}
