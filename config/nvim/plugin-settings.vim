" vim:foldmethod=marker

" VimTeX {{{

if has('macunix')
  let g:vimtex_view_method = 'skim'
endif
let g:vimtex_quickfix_open_on_warning = 0

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

" dirvish {{{

let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" }}}

" svelte {{{

let g:svelte_preprocessor_tags = [
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]
let g:svelte_preprocessors = ['typescript', 'ts']

" }}}
