let g:neomake_javascript_enabled_makers = ['flow']

let g:neomake_javascript_flow_maker = {
  \ 'args': ['--old-output-format'],
  \ 'errorformat': '%f:%l:%c\,%n: %m',
  \ 'mapexpr': 'substitute(v:val, "\\\\n", " ", "g")',
  \ }

augroup myNeomakeAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.flow Neomake
augroup END
