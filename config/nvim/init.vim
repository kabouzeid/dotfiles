" vim:foldmethod=marker

scriptencoding utf-8

:lua require("plugins")

" options {{{

set termguicolors

" let g:rose_pine_variant = 'moon'
colorscheme github_dark_default
syntax enable

set tabstop=2
set shiftwidth=0 " 0 => use same value as tabstop
set expandtab
set smartindent
filetype plugin indent on

set listchars=trail:·,nbsp:_,tab:\ \ 
set list
set shortmess+=tIc
set showcmd
set noshowmode
set ignorecase
set smartcase
set signcolumn=yes
set diffopt+=iwhite
set scrolloff=5
set undofile
set completeopt=menuone,noselect
set updatetime=250
set clipboard=unnamedplus
set spelllang=en_us,de_de
set number
set relativenumber
set cursorline
set timeoutlen=250

" }}}

" GUI {{{

set guifont=JetBrains\ Mono\ Symbols:h13
let g:neovide_cursor_vfx_mode = 'pixiedust'
let g:neovide_floating_opacity = 0.85
let g:neovide_background_color = synIDattr(synIDtrans(hlID("Normal")), "bg#")

" }}}

" filetypes {{{

let g:tex_flavor='latex'
let g:tex_conceal='abdmg'

augroup auto_filetypes
  autocmd!

  autocmd BufRead,BufNewFile *.cls set filetype=tex
  " autocmd Filetype tex set conceallevel=1

  autocmd FileType markdown setlocal conceallevel=2

  autocmd Filetype lspinfo setlocal nowrap

  autocmd Filetype NvimTree setlocal cursorline

  autocmd BufRead,BufNewFile *.ff set filetype=fontforge_script
augroup END

" }}}

" mappings {{{

let mapleader = " "
let maplocalleader = ","

" double expand because of environment vars
if has('macunix')
  nnoremap <silent> gx :execute 'silent! !open ' . shellescape(expand(expand('<cfile>')), 1)<CR>
else
  nnoremap <silent> gx :execute 'silent! !xdg-open ' . shellescape(expand(expand('<cfile>')), 1)<CR>
endif

" Helix

noremap ge G
noremap gh 0
noremap gl $
noremap gs ^

" Add undo break-points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u

" better indenting
vnoremap < <gv
vnoremap > >gv

" }}}

" utilities {{{

function! SyntaxItem()
  return synIDattr(synID(line('.'),col('.'),1),'name')
endfunction

command! Config tabnew|tcd ~/.config/nvim|edit .

command! PackerSource source ~/.config/nvim/lua/plugins.lua
" }}}

:lua require("init")
