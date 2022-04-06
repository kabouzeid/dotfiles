require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/playground") -- treesitter debugging

  -- LSP
  use("neovim/nvim-lspconfig")
  -- use("~/Code/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("kosayoda/nvim-lightbulb")
  use("folke/lsp-trouble.nvim")
  use("arkav/lualine-lsp-progress")
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
  use("ii14/lsp-command")
  use("b0o/schemastore.nvim") -- for jsonls

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/vim-vsnip", requires = "kitagry/vs-snippets" },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "kdheepak/cmp-latex-symbols",
      "quangnguyen30192/cmp-nvim-tags",
      "ray-x/cmp-treesitter",
    },
  })

  -- DAP
  use("mfussenegger/nvim-dap")
  use({ "theHamsta/nvim-dap-virtual-text", requires = "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" })
  use({ "mfussenegger/nvim-dap-python", requires = "mfussenegger/nvim-dap" })

  -- Color
  use("norcalli/nvim-colorizer.lua")
  use("rktjmp/lush.nvim")

  -- Themes
  use({ "rose-pine/neovim", as = "rose-pine" })
  -- use "~/Code/rose-pine"
  use("projekt0n/github-nvim-theme")
  -- use("Pocco81/Catppuccino.nvim")
  -- use("bluz71/vim-moonfly-colors")
  -- use({ "kabouzeid/nvim-jellybeans", requires = "rktjmp/lush.nvim" })
  -- use { "~/Code/nvim-jellybeans", requires = "rktjmp/lush.nvim" }
  -- use("sainnhe/sonokai")
  -- use("sainnhe/edge")
  -- use("sainnhe/everforest")
  -- use("sainnhe/gruvbox-material")
  -- use("kyazdani42/nvim-palenight.lua")
  -- use("folke/tokyonight.nvim")
  -- use("tjdevries/colorbuddy.vim")
  -- use("tjdevries/gruvbuddy.nvim")
  -- use("Th3Whit3Wolf/spacebuddy")
  -- use("Luxed/ayu-vim")
  -- use("connorholyday/vim-snazzy")
  -- use("fratajczak/one-monokai-vim")
  -- use("crusoexia/vim-monokai")
  -- use("rakr/vim-one")
  -- use("joshdick/onedark.vim")
  -- use({ "olimorris/onedark.nvim", requires = "rktjmp/lush.nvim" })
  -- use({ "alaric/nortia.nvim", requires = "rktjmp/lush.nvim" })
  -- use("junegunn/seoul256.vim")
  -- use("mhartington/oceanic-next")
  -- use("saltdotac/citylights.vim")

  -- Edit
  use("tpope/vim-surround")
  use("Raimondi/delimitMate")
  use("numToStr/Comment.nvim")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Movement
  use("ggandor/lightspeed.nvim")

  -- UI
  use("nvim-lualine/lualine.nvim")
  use("folke/zen-mode.nvim")
  use("folke/twilight.nvim")
  use("akinsho/nvim-toggleterm.lua")

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  })
  use("nvim-telescope/telescope-dap.nvim")
  -- use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Files
  use("justinmk/vim-dirvish")
  use("justinmk/vim-gtfo")
  use("tpope/vim-eunuch")
  use("kyazdani42/nvim-tree.lua")
  use("kyazdani42/nvim-web-devicons")
  use("yamatsum/nvim-nonicons")

  -- Git
  use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })
  use("lambdalisue/gina.vim") -- mostly for the :Blame command
  use("kdheepak/lazygit.nvim")

  -- Lang
  use("folke/lua-dev.nvim")
  use("lervag/vimtex")
  -- use("petRUShka/vim-gap")
  -- use("petRUShka/vim-magma")
  -- use("kabouzeid/vim-singular")
  -- use("westeri/asl-vim") -- ACPI
  -- use("tikhomirov/vim-glsl")
  use("mattn/emmet-vim")
  use("pest-parser/pest.vim")
  use("jwalton512/vim-blade")
  use("pantharshit00/vim-prisma")
  use("evanleck/vim-svelte")
  use("rust-lang/rust.vim")
  use("simrat39/rust-tools.nvim") -- additional rust goodies, mostly lsp related
  use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
  use("fladson/vim-kitty")
  use ("vim-scripts/fontforge_script.vim")

  -- Misc
  use("tpope/vim-sleuth")
  use("wincent/terminus")
  use("tpope/vim-unimpaired")
  use("milisims/nvim-luaref")
  use("folke/which-key.nvim")
  use("mickael-menu/zk-nvim")
  -- use("~/Code/zk-nvim")
  use("nanotee/zoxide.vim")
  use("trapd00r/vidir")

  -- Experimenting
  use("danymat/neogen")
end)

vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup END
]])
