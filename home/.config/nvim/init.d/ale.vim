" settings for w0rp/ale

let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_sign_info = ""
let g:ale_sign_style_error = ""
let g:ale_sign_style_warning = ""

let g:ale_linters = {
      \ 'javascript': [],
      \ 'go': ['gometalinter'],
      \ 'typescript': ['eslint']
      \}

let g:ale_fixers = {
      \ 'go': ['gofmt', 'goimports'],
      \ 'javascript': [],
      \ 'typescript': ['prettier'],
      \}

" options for golang
let g:ale_go_gometalinter_executable = 'gometalinter.v2'
let g:ale_go_gometalinter_options = '--fast'

" disable linting for node_modules/
let g:ale_pattern_options = {
      \ '.*/node_modules/.*': { 'ale_enabled': 0 },
      \}

let g:ale_fix_on_save = 1
