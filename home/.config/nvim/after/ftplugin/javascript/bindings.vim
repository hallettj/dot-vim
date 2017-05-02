nnoremap <leader>afr :Tabularize /\(\s\+\)\@<=from\(\s\+\)\@=<cr>
nnoremap <leader>a.  :Tabularize /\./l0l0<cr>

" maksimr/vim-jsbeautify {{{
  nnoremap <buffer> <leader>js :call JsBeautify()<cr>
"}}}

nnoremap <buffer> <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<cr>
