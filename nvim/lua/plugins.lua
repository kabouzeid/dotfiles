require"packer".startup(function(use)
  use "wbthomason/packer.nvim"

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/playground" -- treesitter debugging

  -- LSP
  use "neovim/nvim-lspconfig"
  use "~/Code/nvim-lspinstall"
  use "kosayoda/nvim-lightbulb"
  use "folke/lsp-trouble.nvim"

  -- Completion
  use "hrsh7th/nvim-compe"
  use "wellle/tmux-complete.vim"
  use "GoldsteinE/compe-latex-symbols"

  -- DAP
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"

  -- Color
  use "norcalli/nvim-colorizer.lua"
  use "rktjmp/lush.nvim"
  use { "~/Code/nvim-jellybeans", requires = "rktjmp/lush.nvim" }
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
  use "tpope/vim-commentary"

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
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

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

  -- Snippets
  use { "hrsh7th/vim-vsnip", requires = "kitagry/vs-snippets" }

  -- Lang
  use "lervag/vimtex"
  use "petRUShka/vim-gap"
  use "petRUShka/vim-magma"
  use "~/Code/vim-singular"
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

  -- Experimenting
  use "tpope/vim-unimpaired"
end)
