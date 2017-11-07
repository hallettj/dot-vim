let g:neomake_javascript_enabled_makers = ['flow']

let g:neomake_go_gometalinter_exe = 'gometalinter.v1'
let g:neomake_go_gometalinter_args = ['--vendor', '--disable-all', '--enable=vet', '--enable=vetshadow', '--enable=golint', '--enable=ineffassign', '--enable=goconst', '--enable=errcheck', '--tests']

augroup myNeomakeAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.flow Neomake
  autocmd BufWritePost *.go, Neomake gometalinter
augroup END

" Disable vim-flow's save hook - we just want the jump-to-definition feature
let g:flow#enable = 0
let g:flow#omnifunc = 0
