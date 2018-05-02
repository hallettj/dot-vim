" settings for w0rp/ale

" Override default eslint linter - skip linting if config file is not present.
call ale#linter#Define('javascript', {
\   'name': 'eslint',
\   'output_stream': 'both',
\   'executable_callback': 'ale#handlers#eslint#GetExecutable',
\   'command_callback': 'GetESLintCommandIfConfigPresent',
\   'callback': 'ale#handlers#eslint#Handle',
\})

function! GetESLintCommandIfConfigPresent(buffer) abort
  if filereadable(".eslintrc")
    return ale#handlers#eslint#GetCommand(a:buffer)
  else
    return ""
  endif
endfunction

" I want to disable xml linting while I am working with Salesforce's DTD-less
" XML file formats.
let g:ale_linters = {
      \ 'go': ['gometalinter'],
      \ 'xml': [],
      \}

let g:ale_fixers = {
      \ 'go': ['gofmt', 'goimports'],
      \ 'javascript': ['prettier-standard'],
      \}

" options for golang
let g:ale_go_gometalinter_executable = 'gometalinter.v2'
let g:ale_go_gometalinter_options = '--fast'
