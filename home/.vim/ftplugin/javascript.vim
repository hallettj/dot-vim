let g:syntastic_javascript_checkers = ['flow']

" maksimr/vim-jsbeautify {{{
  nnoremap <buffer> <leader>js :call JsBeautify()<cr>
"}}}

" marijnh/tern_for_vim {{{
  nnoremap <buffer> <silent> <leader>td :TernDef<cr>
  nnoremap <buffer> <silent> <leader>tD :TernDefSplit<cr>
  nnoremap <buffer> <silent> <leader>tr :TernRefs<cr>
  nnoremap <buffer> <silent> <leader>tc :TernRename<cr>
"}}}
