"--------
" Goyo
"--------

nnoremap <C-w>G :Goyo<CR>

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set signcolumn=no
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set signcolumn=yes
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


"--------
" VimTeX
"--------

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

"--------
" Lightline
"--------

augroup GutentagsStatusLineRefresher
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END

function! LightlineTreeSitter() abort
  let status = nvim_treesitter#statusline(90)
  if status == v:null | return '' | endif
  return status
endfunction

function! LightlineGit() abort
  let branch = get(b:,'gitsigns_head','')
  if branch == '' | return '' | endif
  let status = get(b:,'gitsigns_status','')
  let separator = status == '' ? '' : ' '
  return "\uE0A0 " . branch . separator . status
endfunction

function! LightlineCondEncoding() abort
  return &encoding == 'utf-8' ? '' : &encoding
endfunction

function! LightlineCondFormat() abort
  return &fileformat == "unix" ? '' : &fileformat
endfunction

function! LightlineLspStatus() abort
  if !luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
    return ''
  endif
  let sl = ''
  let sl .= 'E:' . luaeval("vim.lsp.diagnostic.get_count(0, [[Error]])")
  let sl .= ' '
  let sl .= 'W:' . luaeval("vim.lsp.diagnostic.get_count(0, [[Warning]])")
  return sl
endfunction

let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \     'left': [
      \         [ 'mode', 'paste' ],
      \         [ 'gitbranch', 'readonly', 'fileformat', 'fileencoding', 'filename', 'modified' ],
      \         [ 'gutentags_status' ],
      \     ],
      \     'right': [
      \         [ 'lspstatus' ],
      \         [ 'filetype' ],
      \         [ 'treesitter' ],
      \     ]
      \ },
      \ 'component_function': {
      \     'gitbranch': 'LightlineGit',
      \     'treesitter': 'LightlineTreeSitter',
      \     'lspstatus': 'LightlineLspStatus',
      \     'fileformat': 'LightlineCondFormat',
      \     'fileencoding': 'LightlineCondEncoding',
      \ },
      \ }

"--------
" CHADTree
"--------

nnoremap <leader>c <cmd>CHADopen<cr>

let g:chadtree_settings =
      \ {
      \ 'theme.icon_glyph_set': 'ascii',
      \ 'options.mimetypes.warn': [],
      \ }

"-----
" GTFO
"-----
let g:gtfo#terminals = { 'mac': 'iterm' }


"----------
" gutentags
"----------
let g:gutentags_ctags_exclude = ['.ccls-cache']


"----
" FZF
"----
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
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
      \ 'header':  ['fg', 'Comment']
      \}
