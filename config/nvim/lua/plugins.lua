require"packer".startup(function(use)
  use "wbthomason/packer.nvim"

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/playground" -- treesitter debugging

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "kosayoda/nvim-lightbulb"
  use "folke/lsp-trouble.nvim"

  -- Linting
  use "mfussenegger/nvim-lint"

  -- Completion
  --[[ use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    requires = {
      use { 'ms-jpq/coq.artifacts', branch= 'artifacts'}
    }
  } ]]
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/vim-vsnip", requires = "kitagry/vs-snippets" },
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "andersevenrud/compe-tmux",
      "kdheepak/cmp-latex-symbols",
      "f3fora/cmp-spell",
      "quangnguyen30192/cmp-nvim-tags",
      "ray-x/cmp-treesitter",
    }
  }

  -- DAP
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"

  -- Color
  use "norcalli/nvim-colorizer.lua"
  use "rktjmp/lush.nvim"

  -- Themes
  use { "rose-pine/neovim", as = 'rose-pine' }
  -- use "~/Code/rose-pine"
  -- use "Pocco81/Catppuccino.nvim"
  -- use { "kabouzeid/nvim-jellybeans", requires = "rktjmp/lush.nvim" }
  -- use "sainnhe/sonokai"
  -- use "sainnhe/edge"
  -- use "sainnhe/everforest"
  -- use "sainnhe/gruvbox-material"
  -- use "kyazdani42/nvim-palenight.lua"
  -- use "folke/tokyonight.nvim"
  -- use "tjdevries/colorbuddy.vim"
  -- use "tjdevries/gruvbuddy.nvim"
  -- use "Th3Whit3Wolf/spacebuddy"
  -- use "Luxed/ayu-vim"
  -- use "connorholyday/vim-snazzy"
  -- use "fratajczak/one-monokai-vim"
  -- use "crusoexia/vim-monokai"
  -- use "rakr/vim-one"
  -- use "joshdick/onedark.vim"
  -- use { "olimorris/onedark.nvim", requires = "rktjmp/lush.nvim" }
  -- use { "alaric/nortia.nvim", requires = "rktjmp/lush.nvim" }
  -- use "junegunn/seoul256.vim"
  -- use "mhartington/oceanic-next"
  -- use "saltdotac/citylights.vim"

  -- Edit
  use "tpope/vim-surround"
  use "Raimondi/delimitMate"
  use "numToStr/Comment.nvim"

  -- Movement
  use "justinmk/vim-sneak"
  use "tpope/vim-sleuth"

  -- UI
  use "hoob3rt/lualine.nvim"
  use "folke/zen-mode.nvim"
  use "akinsho/nvim-toggleterm.lua"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  }
  use "nvim-telescope/telescope-dap.nvim"
  -- use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Files
  use "justinmk/vim-dirvish"
  use "justinmk/vim-gtfo"
  use "tpope/vim-eunuch"
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "yamatsum/nvim-nonicons"

  -- Git
  use { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" }
  use "lambdalisue/gina.vim"
  use "kdheepak/lazygit.nvim"

  -- Lang
  use "lervag/vimtex"
  use "petRUShka/vim-gap"
  use "petRUShka/vim-magma"
  use "kabouzeid/vim-singular"
  use "westeri/asl-vim" -- ACPI
  use "tikhomirov/vim-glsl"
  use "mattn/emmet-vim"
  use "pest-parser/pest.vim"
  use "jwalton512/vim-blade"
  use "pantharshit00/vim-prisma"

  -- Misc
  use "wincent/terminus"
  use "marcushwz/nvim-workbench"
  use "milisims/nvim-luaref"
  use "jbyuki/nabla.nvim"
  use "folke/which-key.nvim"
  --[[ use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  } ]]

  -- Experimenting
  use "tpope/vim-unimpaired"
end)
