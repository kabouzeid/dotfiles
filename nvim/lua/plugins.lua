require"packer".startup(function(use)
  use "wbthomason/packer.nvim"
  use "wincent/terminus"

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use 'nvim-treesitter/playground' -- treesitter debugging

  -- LSP
  use "neovim/nvim-lspconfig"
  use "~/Code/nvim-lspinstall"
  use "kosayoda/nvim-lightbulb"

  -- Completion
  use "hrsh7th/nvim-compe"
  use "wellle/tmux-complete.vim"
  use "GoldsteinE/compe-latex-symbols"

  -- DAP
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"

  -- Color
  use "sainnhe/sonokai"
  use "norcalli/nvim-colorizer.lua"

  -- Edit
  use "tpope/vim-surround" -- vim objects for brackets etc
  use "Raimondi/delimitMate" -- auto close brackets
  use "tpope/vim-commentary"

  -- Movement
  use "justinmk/vim-sneak" -- sneak to locations
  use "tpope/vim-sleuth" -- auto indentation detection

  -- UI
  use "itchyny/lightline.vim"
  use "junegunn/goyo.vim" -- distraction free writing
  use "akinsho/nvim-toggleterm.lua"

	-- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" }
  }
  use 'nvim-telescope/telescope-dap.nvim'

  -- Files
  use "justinmk/vim-dirvish"
  use "tpope/vim-eunuch"
  use "justinmk/vim-gtfo" -- open file in system explorer/terminal
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "yamatsum/nvim-web-nonicons"

  -- Git
  use { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- Snippets
  use { "hrsh7th/vim-vsnip", requires = "kitagry/vs-snippets" }

  -- Lang
  use "lervag/vimtex"
  use "petRUShka/vim-gap"
  use "petRUShka/vim-magma"
  use "kabouzeid/vim-singular"
  use "westeri/asl-vim" -- ACPI
  use "tikhomirov/vim-glsl" -- GLSL (OpenGL Shader)
  use "mattn/emmet-vim"
  use "pest-parser/pest.vim" -- pest parser generator
  use "jwalton512/vim-blade"

  -- Misc
  use { "prettier/vim-prettier", run = "yarn install" }

  -- Experimenting
  use "tpope/vim-unimpaired"
end)
