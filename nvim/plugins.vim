call plug#begin()

" -- General
Plug 'wincent/terminus'
" Plug 'mileszs/ack.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" -- LSP
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
" Plug '~/Code/nvim-lspconfig'
" Plug 'kabouzeid/nvim-lspinstall'
Plug '~/Code/nvim-lspinstall'
" Plug 'onsails/lspkind-nvim'
Plug 'kosayoda/nvim-lightbulb'

" -- Completion
Plug 'hrsh7th/nvim-compe'
" Plug 'nvim-lua/completion-nvim' | Plug 'hrsh7th/vim-vsnip-integ'
Plug 'wellle/tmux-complete.vim'

" -- Color
Plug 'sainnhe/sonokai'
" Plug 'vimpostor/vim-prism'
" Plug 'dracula/vim', { 'as': 'dracula'}
" Plug 'whatyouhide/vim-gotham'
" Plug 'joshdick/onedark.vim'
" Plug 'sonph/onehalf'
" Plug 'rakr/vim-one'
" Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" Plug 'tomasr/molokai'
" Plug 'phanviet/vim-monokai-pro'
" Plug 'patstockwell/vim-monokai-tasty'
Plug 'norcalli/nvim-colorizer.lua'

" -- Edit
Plug 'tpope/vim-surround' " vim objects for brackets etc
Plug 'Raimondi/delimitMate' " auto close brackets
" Plug 'vim-scripts/ReplaceWithRegister' " we already use nmap gr for coc
Plug 'tpope/vim-commentary'

" -- Movement
Plug 'justinmk/vim-sneak' " sneak to locations
Plug 'tpope/vim-sleuth' " auto indentation detection

" -- UI
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
" Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " fuzzy finder
Plug 'junegunn/goyo.vim' " distraction free writing
Plug 'akinsho/nvim-toggleterm.lua'

" -- Files
" Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-dirvish'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-gtfo' " open file in system explorer/terminal
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'yamatsum/nvim-web-nonicons'

" -- Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
" Plug 'airblade/vim-gitgutter'
" Plug 'itchyny/vim-gitbranch'

" -- Snippets
Plug 'hrsh7th/vim-vsnip' | Plug 'kitagry/vs-snippets'
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" -- Lang
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'petRUShka/vim-gap'
Plug 'petRUShka/vim-magma'
Plug 'kabouzeid/vim-singular'
Plug 'bumaociyuan/vim-swift'
Plug 'leafgarland/typescript-vim'
Plug 'westeri/asl-vim' " ACPI
Plug 'tikhomirov/vim-glsl' " GLSL (OpenGL Shader)
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'pest-parser/pest.vim'
Plug 'jwalton512/vim-blade'

" -- Tags
" Plug 'majutsushi/tagbar' " displays ctags in sidebar
" Plug 'ludovicchabant/vim-gutentags' " automatically generates ctags

" -- Misc
Plug 'junegunn/vader.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'nvim-lua/plenary.nvim' " needed by some lua plugins

" Experimenting
Plug 'tpope/vim-unimpaired'

Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'

Plug 'GoldsteinE/compe-latex-symbols'

" Plug 'ray-x/lsp_signature.nvim'

" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-telescope/telescope.nvim'
call plug#end()
