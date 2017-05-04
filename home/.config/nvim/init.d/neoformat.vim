let g:neoformat_only_msg_on_error = 1

augroup gofmt
  autocmd!
  autocmd BufWritePre *.go,*.js,*.jsx,*.flow Neoformat
augroup end
