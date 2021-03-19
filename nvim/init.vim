set nocompatible " be iMproved

function! Source(name)
  if has('nvim')
    exec 'source' stdpath('config') . '/' . a:name . '.vim'
  else
    exec 'source' '~/.config/nvim/' . a:name . '.vim'
  endif
endfunc

call Source('plugins')

" Set theme
set background=dark
" let g:sonokai_style = 'maia'
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_sign_column_background = 'none'
let g:sonokai_enable_italic = 1
colorscheme sonokai
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Set tab width
set tabstop=2
set shiftwidth=0 " 0 => use same value as tabstop
set expandtab
set smartindent
filetype plugin on
filetype plugin indent on

set fileformat=unix
" Show “invisible” characters
set listchars=trail:·,nbsp:_,tab:\ \ 
set list
" Highlight searches
set hlsearch
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess+=atIc
" Show the (partial) command as it’s being typed
set showcmd
" Hide the mode, it's already shown by the airline plugin
set noshowmode
set lazyredraw
set ignorecase
set smartcase
set autoread
" Allows jumping between tags without saving
set hidden

set ttimeoutlen=10

" Always show the signcolumn
set signcolumn=yes


if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let delimitMate_expand_cr=1

" nnoremap j gj
" nnoremap gj j

" nnoremap k gk
" nnoremap gk k

" nnoremap $ g$
" nnoremap g$ $

" nnoremap 0 g0
" nnoremap g0 0

" Make Y behave like other capitals
nnoremap Y y$

set diffopt+=iwhite

set scrolloff=5

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
let python_highlight_all=1

set undofile " Persistent undo history
set undodir=~/.config/nvim/undo " Undo data location
set directory=~/.config/nvim/swap " Swap file location
set backupdir=~/.config/nvim/backup " Backup file location

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

set completeopt=menuone,noselect

set updatetime=300

augroup auto_filetypes
  autocmd!
  " Latex
  autocmd BufRead,BufNewFile *.cls set filetype=tex
  " autocmd Filetype tex set conceallevel=1
  " Tex
  autocmd Filetype tex setlocal spell
  " Cocoapods
  autocmd BufRead,BufNewFile Podfile set filetype=ruby
  " " Singular
  " autocmd BufNewFile,BufRead *.lib,*.tst silent set filetype=singular | set syntax=singular | set indentexpr=
  " Vapor Leaf
  autocmd BufRead,BufNewFile *.leaf set filetype=html
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
  let count = len(project_roots)
  if (count == 1)
    return project_roots[0]
  elseif (count > 1)
    let choices = copy(project_roots)
    call map(choices, 'v:key + 1 . ". " . v:val') " format them
    let index = inputlist(["Specify project root directory"] + choices) - 1
    if (index >= 0 && index < count)
      return project_roots[index]
    endif
  endif
endfunction

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set clipboard=unnamed

if !has('nvim')
  if exists('$TMUX')
    " tmux cursor
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    " iTerm2 cursor
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
set spelllang=en_us,de_de

nnoremap <C-L> :nohlsearch<CR><C-L>

if has('python3')
  set pyx=3
elseif has('python')
  set pyx=2
endif

" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

function! s:tabterm(...) abort
  if a:0 == 0
    tabedit term://$SHELL
  else
    execute "tabedit term://" . a:1
  endif
endfunction
command! -nargs=? -complete=shellcmd Tabterm call <SID>tabterm(<f-args>) " eg `:tabterm yarn dev` will open a new tab and run `yarn dev`

function! s:init_file() abort
  return stdpath("config") .. "/init.vim"
endfunction
command! -nargs=0 Config execute "edit " .. <SID>init_file()
function! s:lsp_config_file() abort
  return stdpath("config") .. "/lua/lsp-settings.lua"
endfunction
command! -nargs=0 LspConfig execute "edit " .. <SID>lsp_config_file()

if executable("rustywind")
  command! -nargs=0 Headwind :!rustywind --write %
endif

call Source('plugin-settings')
:lua require'init'
