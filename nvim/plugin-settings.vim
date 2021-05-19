" vim:foldmethod=marker

" compe {{{

" Jump forward or backward
imap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

" }}}

" Goyo {{{

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

augroup Goyo
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

" }}}

" VimTeX {{{

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

" }}}

" NvimTree {{{

nnoremap <leader>tt <cmd>NvimTreeToggle<cr>
nnoremap <leader>tf <cmd>NvimTreeFindFile<cr>

" }}}

" GTFO {{{

let g:gtfo#terminals = { 'mac': 'kitty' }

" }}}

" gutentags {{{

let g:gutentags_ctags_exclude = ['.ccls-cache']

" }}}

" Packer {{{

augroup Packer
  autocmd!
  autocmd BufWritePost plugins.lua PackerCompile
augroup END

" }}}

" Telescope {{{

nnoremap <leader>fp <cmd>Telescope<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fd <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" }}}

" nvim-workbench {{{

nmap <leader>bp <Plug>ToggleProjectWorkbench
nmap <leader>bb <Plug>ToggleBranchWorkbench
let g:workbench_storage_path = stdpath('data') . '/workbench/'

" }}}

" delimitMate {{{

let delimitMate_expand_cr=1

" }}}

" gina {{{

command! Blame Gina blame

" }}}
