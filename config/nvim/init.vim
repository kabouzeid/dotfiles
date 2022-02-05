" vim:foldmethod=marker

scriptencoding utf-8

:lua require'plugins'

" options {{{

set termguicolors

let g:rose_pine_variant = 'moon'
colorscheme rose-pine
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

set hidden

" }}}

" GUI {{{

set guifont=JetBrains\ Mono,nonicons,Symbols\ Nerd\ Font:h11
let g:neovide_cursor_vfx_mode = 'pixiedust'
let g:neovide_floating_opacity = 0.85

" }}}

" filetypes {{{

let g:tex_flavor='latex'
let g:tex_conceal='abdmg'

augroup auto_filetypes
  autocmd!

  autocmd BufRead,BufNewFile *.cls set filetype=tex
  autocmd Filetype tex setlocal spell
  " autocmd Filetype tex set conceallevel=1

  autocmd Filetype markdown setlocal spell
  autocmd FileType markdown setlocal conceallevel=2

  autocmd Filetype text setlocal spell

  autocmd Filetype lspinfo setlocal nowrap

  autocmd Filetype NvimTree setlocal cursorline
augroup END

" }}}

" mappings {{{

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" }}}

" utilities {{{

function! s:tabterm(...) abort
  if a:0 == 0
    tabedit term://$SHELL
  else
    execute 'tabedit term://' . a:1
  endif
endfunction
command! -nargs=? -complete=shellcmd Tabterm call <SID>tabterm(<f-args>) " eg `:Tabterm yarn dev` will open a new tab and run `yarn dev`

function! SyntaxItem()
  return synIDattr(synID(line('.'),col('.'),1),'name')
endfunction

command! Config tabnew|tcd ~/.config/nvim|edit .
" }}}

:lua require'init'
