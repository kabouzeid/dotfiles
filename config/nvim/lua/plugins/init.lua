return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  "folke/which-key.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  { "yamatsum/nvim-nonicons" },
  {
    "williamboman/mason.nvim",
    dependencies = { "yamatsum/nvim-nonicons" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = require("nvim-nonicons").get("check-circle"),
            package_pending = require("nvim-nonicons").get("clock"),
            package_uninstalled = require("nvim-nonicons").get("circle"),
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = false,
          },
        },
      })
    end,
  },
  { "norcalli/nvim-colorizer.lua" },
  { "projekt0n/github-nvim-theme", branch = "0.0.x" },
  {
    "tpope/vim-surround",
    init = function()
      vim.g["surround_no_mappings"] = 1
    end,
    config = function()
      vim.keymap.set("n", "ds", "<Plug>Dsurround")
      vim.keymap.set("n", "cs", "<Plug>Csurround")
      vim.keymap.set("n", "cS", "<Plug>CSurround")
      vim.keymap.set("n", "ys", "<Plug>Ysurround")
      vim.keymap.set("n", "yS", "<Plug>YSurround")
      vim.keymap.set("n", "yss", "<Plug>Yssurround")
      vim.keymap.set("n", "ySs", "<Plug>YSsurround")
      vim.keymap.set("n", "ySS", "<Plug>YSsurround")
      -- The conflicting ones.
      vim.keymap.set("x", "z", "<Plug>VSurround")
      vim.keymap.set("x", "Z", "<Plug>VgSurround")
    end,
  },
  { "Raimondi/delimitMate" },
  {
    "justinmk/vim-dirvish",
    config = function()
      vim.g.loaded_netrwPlugin = 1 -- comment this out when need to download spell files
      vim.cmd([[
  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
]])
    end,
  },
  {
    "justinmk/vim-gtfo",
    config = function()
      vim.g["gtfo#terminals"] = { unix = "ghostty", mac = "ghostty" }
    end,
  },
  { "tpope/vim-eunuch" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-unimpaired" },
  {
    "nanotee/zoxide.vim",
    config = function()
      vim.g.zoxide_hook = "pwd"
    end,
  },
  { "trapd00r/vidir" },
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },
  { "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
  { "wellle/targets.vim" }
}
