" tabs, not spaces
setlocal noexpandtab

nnoremap <buffer> <leader><leader> :KeepView %!gofmt<enter>

augroup gofmt
  autocmd!
  autocmd BufWritePre *.go Neoformat
augroup end
