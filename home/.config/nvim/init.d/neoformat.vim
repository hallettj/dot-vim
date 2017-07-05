let g:neoformat_only_msg_on_error = 1
let g:neoformat_enabled_javascript = ['prettierstandard'] + neoformat#formatters#javascript#enabled()

let g:neoformat_javascript_prettier = {
  \ 'exe': 'prettier',
  \ 'args': ['--stdin', '--no-semi', '--single-quote'],
  \ 'stdin': 1,
  \ }

let g:neoformat_javascript_prettierstandard = {
  \ 'exe': 'prettier-standard',
  \ 'args': ['--stdin'],
  \ 'stdin': 1,
  \ }

augroup neoformat
  autocmd!
  autocmd BufWritePre *.go,*.js,*.jsx,*.flow undojoin | Neoformat
augroup end
