set nocompatible " be iMproved

call plug#begin('~/.vim/plugged')

" General
Plug 'wincent/terminus'
Plug 'mileszs/ack.vim'

" Color
Plug 'dracula/vim', { 'as': 'dracula'}
Plug 'junegunn/rainbow_parentheses.vim'

" Edit
Plug 'tpope/vim-surround' " vim objects for brackets etc
Plug 'Raimondi/delimitMate' " auto close brackets
" Plug 'vim-scripts/ReplaceWithRegister' " we already use nmap gr for coc
Plug 'tpope/vim-commentary'

" UI
" Plug 'vim-airline/vim-airline' " bottom bar
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " fuzzy finder
Plug 'majutsushi/tagbar' " ctags bar

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Movement
Plug 'justinmk/vim-sneak' " sneak to locations
Plug 'tpope/vim-sleuth' " auto indentation detection

" Snippets
Plug 'honza/vim-snippets' " ultisnips snippets

" Completion
Plug 'Shougo/neco-vim' " VimL support (supported by coc.nvim)
Plug 'Shougo/neoinclude.vim' " C/C++ header files (supported by coc.nvim)

" Lang
Plug 'lervag/vimtex' " provides omnicompletion, text objects and more for LaTeX
Plug 'octol/vim-cpp-enhanced-highlight' " better syntax highlighting for cpp
Plug 'petRUShka/vim-gap' " GAP lang support
Plug 'petRUShka/vim-magma' " MAGMA lang support
Plug 'bumaociyuan/vim-swift' " clone of official apple swift syntax plugin
Plug 'leafgarland/typescript-vim' " typescript syntax
Plug 'westeri/asl-vim' " ACPI
Plug 'tikhomirov/vim-glsl' " GLSL (OpenGL Shader)

" Tags
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' } " displays ctags in sidebar
Plug 'ludovicchabant/vim-gutentags' " automatically generates ctags

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP and completion framework, build from source
Plug 'neoclide/coc-neco' " support neco-vim in coc.nvim
Plug 'jsfaint/coc-neoinclude' " support neoinclude in coc.nvim
Plug 'wellle/tmux-complete.vim'

call plug#end()

" Set theme
set background=dark
" colorscheme gruvbox
colorscheme dracula
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
" set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
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

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  " Always show the signcolumn
  set signcolumn=yes
endif

let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-python', 'coc-texlab', 'coc-yaml', 'coc-vimlsp', 'coc-sourcekit', 'coc-sh', 'coc-go', 'coc-snippets']

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let delimitMate_expand_cr=1

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

set updatetime=300

augroup auto_filetypes
  autocmd!
  " Latex
  autocmd BufRead,BufNewFile *.cls set filetype=tex
  autocmd Filetype tex set conceallevel=1
  " autocmd Filetype tex setlocal spell
  " Cocoapods
  autocmd BufRead,BufNewFile Podfile set filetype=ruby
  " Singular
  autocmd BufNewFile,BufRead *.lib,*.tst silent set filetype=singular | set syntax=singular | set indentexpr=
  " C
  autocmd FileType c,cpp call AutoGenerateClangCompileFlags()
  " Vapor Leaf
  autocmd BufRead,BufNewFile *.leaf set filetype=html
augroup END

function! _GenerateClangCompileFlags(project_root)
  let dirs = split(glob(a:project_root.'/*'), '\n') + [a:project_root] " get the dirs in the root dir
  call filter(dirs, 'isdirectory(v:val)')
  call map(dirs, '"-I" . v:val') " format them
  let compile_flags = dirs
  if has('macunix')
    " eg for gmp and so on installed via Homebrew
    let compile_flags = ['-I/usr/local/include'] + compile_flags
  endif
  return compile_flags
endfunction

command! -nargs=0 GenerateClangCompileFlags :call GenerateClangCompileFlags()

function! GenerateClangCompileFlags() " includes all dirs at the project root
  if (get(g:, 'coc_service_initialized', 0) == 0)
    return
  endif
  let project_root = ProjectRoot()
  if !empty(project_root)
    let compile_flags = _GenerateClangCompileFlags(project_root)

    let compile_flags_filename = project_root . '/compile_flags.txt'
    call writefile(compile_flags, compile_flags_filename)
    echo "generated file " . compile_flags_filename
  endif
endfunction

function! AutoGenerateClangCompileFlags()
  if (&filetype != 'c' && &filetype != 'cpp')
    return
  endif
  if get(g:, 'coc_service_initialized', 0) == 0
    return
  endif
  let project_root = ProjectRoot()
  if !empty(project_root)
    let compile_flags_filename = project_root . '/compile_flags.txt'
    if !file_readable(compile_flags_filename)
      let compile_flags = _GenerateClangCompileFlags(project_root)
      call writefile(compile_flags, compile_flags_filename)
      echo "auto generated file " . compile_flags_filename
    endif
  endif
endfunction

function! ProjectRoot()
  let project_roots = get(g:, 'WorkspaceFolders', []) " set by coc.nvim
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

" LSP
let g:gutentags_ctags_exclude = ['.ccls-cache']

" vimtex
if !has('clientserver') && !has('nvim')
  let g:vimtex_compiler_latexmk = {'callback' : 0}
endif
if has('nvim')
  let g:vimtex_compiler_progname = 'nvr'
endif
if has('macunix') " macOS only
  let g:vimtex_view_method = 'skim'
endif
let g:vimtex_quickfix_open_on_warning = 0

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

command Cdev NERDTree | Tagbar

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use gK to show documentation in preview window (because K is default in vim).
nnoremap <silent> gK :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

augroup autococ
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Update status line after diagnostics change
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  autocmd User CocNvimInit call lightline#update()

  autocmd User CocNvimInit call AutoGenerateClangCompileFlags()

augroup end

augroup GutentagsStatusLineRefresher
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END

let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
let spelllang='en,de'

" for dracula, display conceal as normal text (dracula sets some weird colors otherwise)
highlight Conceal guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE

function! CocWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'warning', 0) == 0 | return '' | endif
  return 'W:' . info['warning']
endfunction

function! CocErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0) == 0 | return '' | endif
  return 'E:' . info['error']
endfunction

function! CocStatus() abort
  return get(g:, 'coc_status', '')
endfunction

function! GitBranch() abort
  let branch = FugitiveHead(9) " if head is detached, return 9 chars of commit hash
  return empty(branch) ? '' : ('ᚠ ' . branch)
endfunction

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \     'left': [
      \         [ 'mode', 'paste' ],
      \         [ 'gitbranch', 'readonly', 'filename', 'modified']
      \     ],
      \     'right': [
      \         [ 'gutentags_status', 'coc_status', 'coc_errors', 'coc_warnings', 'lineinfo' ],
      \         [ 'percent' ],
      \         [ 'fileformat', 'fileencoding', 'filetype' ]
      \     ]
      \ },
      \ 'component_function': {
      \     'gitbranch': 'GitBranch',
      \ },
      \ 'component_expand': {
      \     'coc_warnings': 'CocWarnings',
      \     'coc_errors': 'CocErrors',
      \     'coc_status': 'CocStatus',
      \     'gutentags_status': 'gutentags#statusline',
      \ },
      \ 'component_type': {
      \     'coc_warnings': 'warning',
      \     'coc_errors': 'error',
      \     'coc_status': 'right',
      \     'gutentags_status': 'right',
      \ }
      \ }

nnoremap <C-L> :nohlsearch<CR><C-L>

if has('python3')
  set pyx=3
elseif has('python')
  set pyx=2
endif