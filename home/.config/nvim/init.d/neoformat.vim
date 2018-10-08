let g:neoformat_only_msg_on_error = 1
let g:neoformat_enabled_javascript = ['prettierstandard'] + neoformat#formatters#javascript#enabled()
let g:neoformat_enabled_typescript = ['prettier']

let g:neoformat_javascript_prettierstandard = {
  \ 'exe': 'prettier-standard',
  \ 'args': ['--stdin'],
  \ 'stdin': 1,
  \ }
