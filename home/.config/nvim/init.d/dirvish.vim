" Don't need netrw - we are using dirvish instead
let g:loaded_netrwPlugin = 1

augroup dirvish_config
  autocmd!
  " Unmap <C-p> so I can use my file finder shortcut from dirvish buffers
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
augroup END
