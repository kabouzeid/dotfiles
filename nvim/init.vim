scriptencoding utf-8

:lua require'plugins'

set termguicolors
set background=dark

colorscheme jellybeans

syntax enable

set guifont=MonoLisa,nonicon,codicon,3270Medium\ Nerd\ Font

set tabstop=2
set shiftwidth=0 " 0 => use same value as tabstop
set expandtab
set smartindent
filetype plugin indent on

set listchars=trail:·,nbsp:_,tab:\ \ 
set list
set shortmess+=tI
set showcmd
set noshowmode
set lazyredraw
set ignorecase
set smartcase
set autoread
set signcolumn=yes
set diffopt+=iwhite
set scrolloff=5
set undofile
set completeopt=menuone,noselect
set updatetime=300
set clipboard=unnamedplus
set spelllang=en_us,de_de

set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

nnoremap <C-L> :nohlsearch<CR><C-L>

let g:tex_flavor='latex'
let g:tex_conceal='abdmg'

augroup auto_filetypes
  autocmd!
  " LaTeX
  " autocmd Filetype tex set conceallevel=1
  autocmd BufRead,BufNewFile *.cls set filetype=tex
  autocmd Filetype tex setlocal spell
  " Singular
  autocmd BufRead,BufNewFile *.lib,*.tst set filetype=singular
  " Vapor Leaf
  autocmd BufRead,BufNewFile *.leaf set filetype=html
  " lspinfo
  autocmd Filetype lspinfo setlocal nowrap
  " nvim-tree
  autocmd Filetype NvimTree setlocal cursorline
augroup END

function! GenerateClangCompileFlags() " includes all dirs at the project root
  let root = WorkspaceFolder()
  if !empty(root)
    " include all subdirs
    let dirs = split(glob(root . '/*'), '\n') + [root] " get the dirs in the root dir
    call filter(dirs, 'isdirectory(v:val)')
    call map(dirs, '"-I" . v:val') " format them
    let compile_flags = dirs
    if has('macunix')
      " eg for gmp and so on installed via Homebrew
      let compile_flags = ['-I/usr/local/include'] + compile_flags
    endif

    let compile_flags_filename = root . '/compile_flags.txt'
    call writefile(compile_flags, compile_flags_filename)
    echo "generated file " . compile_flags_filename
  endif
endfunction
command! -nargs=0 GenerateClangCompileFlags :call GenerateClangCompileFlags()

function! WorkspaceFolder()
  let project_roots = v:lua.vim.lsp.buf.list_workspace_folders()
  let project_root_count = len(project_roots)
  if (project_root_count == 1)
    return project_roots[0]
  elseif (project_root_count > 1)
    let choices = copy(project_roots)
    call map(choices, 'v:key + 1 . ". " . v:val') " format them
    let index = inputlist(["Specify project root directory"] + choices) - 1
    if (index >= 0 && index < project_root_count)
      return project_roots[index]
    endif
  endif
endfunction

function! s:tabterm(...) abort
  if a:0 == 0
    tabedit term://$SHELL
  else
    execute "tabedit term://" . a:1
  endif
endfunction
command! -nargs=? -complete=shellcmd Tabterm call <SID>tabterm(<f-args>) " eg `:tabterm yarn dev` will open a new tab and run `yarn dev`

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

source ./plugin-settings.vim
:lua require'init'
