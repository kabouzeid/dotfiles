set nocompatible              " be iMproved

call plug#begin('~/.vim/plugged')

" Color
Plug 'dracula/vim'

" Edit
Plug 'tpope/vim-surround' " vim objects for brackets etc
Plug 'Raimondi/delimitMate' " auto close brackets
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-commentary'

" UI
Plug 'vim-airline/vim-airline' " bottom bar
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " fuzzy finder

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Movement
Plug 'justinmk/vim-sneak' " sneak to locations
Plug 'tpope/vim-sleuth' " auto indentation detection

" Completion
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Lang
Plug 'davidhalter/jedi-vim' " python support
Plug 'lervag/vimtex' " contains latex completions
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' } " ctags
Plug 'petRUShka/vim-gap' " gap support

" Lint
Plug 'w0rp/ale'

call plug#end()

" Set theme
set background=dark
" colorscheme gruvbox
colorscheme dracula
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
set binary
set noendofline

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Set tab width
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
filetype plugin on
filetype plugin indent on

set fileformat=unix
" Show “invisible” characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the (partial) command as it’s being typed
set showcmd
" Hide the mode, it's already shown by the airline plugin
set noshowmode
set lazyredraw
set ignorecase
set smartcase
set autoread

set ttimeoutlen=10

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 1
let g:syntastic_mode_map = { 'mode': 'passive' }

let delimitMate_expand_cr=1

let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
                        \ '\v\\%('
                        \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
                        \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
                        \ . '|hyperref\s*\[[^]]*'
                        \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
                        \ . '|%(include%(only)?|input)\s*\{[^}]*'
                        \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
                        \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
                        \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
                        \ . '|usepackage%(\s*\[[^]]*\])?\s*\{[^}]*'
                        \ . '|documentclass%(\s*\[[^]]*\])?\s*\{[^}]*'
                        \ . '|\a*'
                        \ . ')'

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

nnoremap j gj
nnoremap gj j

nnoremap k gk
nnoremap gk k

nnoremap $ g$
nnoremap g$ $

nnoremap 0 g0
nnoremap g0 0

" Make Y behave like other capitals
nnoremap Y y$

set diffopt+=iwhite

set scrolloff=5

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let python_highlight_all=1

set undofile " Persistent undo history
set undodir=~/.vim/undo " Undo data location
set directory=~/.vim/swap " Swap file location
set backupdir=~/.vim/backup " Backup file location

" Alt+j/k moves lines down/up (macOS compatible)
nnoremap <A-j> :m+<CR>==
nnoremap ∆ :m+<CR>==
nnoremap <A-k> :m-2<CR>==
nnoremap ˚ :m-2<CR>==
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap ∆ :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap ˚ :m-2<CR>gv=gv

" Alt+h/l decreases/increases indentation level (macOS compatible)
nnoremap <A-h> <<
nnoremap ˙ <<
nnoremap <A-l> >>
nnoremap ¬ >>
vnoremap <A-h> <gv
vnoremap ˙ <gv
vnoremap <A-l> >gv
vnoremap ¬ >gv

set completeopt-=preview

set updatetime=250 " Can cause glitches"

" Singular
au BufRead,BufNewFile *.lib set filetype=singular | set syntax=singular | set indentexpr=

if !has('clientserver')
  let g:vimtex_compiler_latexmk = {'callback' : 0}
endif

if has('termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
endif

let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

set clipboard=unnamed

nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" iTerm2 cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" tmux cursor
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"