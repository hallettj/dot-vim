" tabs, not spaces
setlocal noexpandtab

nnoremap <buffer> <leader><leader> :KeepView %!gofmt<enter>

augroup gofmt
  autocmd!
  autocmd CursorHold *.go Neoformat
augroup end
