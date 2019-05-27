" settings for w0rp/ale

let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_sign_info = ""
let g:ale_sign_style_error = ""
let g:ale_sign_style_warning = ""

let g:ale_linters = {
      \ 'go': ['gometalinter'],
      \ 'javascript': [],
      \ 'typescript': ['eslint']
      \}

let g:ale_fixers = {
      \ 'go': ['gofmt', 'goimports'],
      \ 'graphql': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'rust': ['rustfmt'],
      \ 'typescript': ['prettier'],
      \}

" options for golang
let g:ale_go_gometalinter_executable = 'gometalinter.v2'
let g:ale_go_gometalinter_options = '--fast'

" disable linting for node_modules/
let g:ale_pattern_options = {
      \ '.*/node_modules/.*': { 'ale_enabled': 0 },
      \}

" do not turn on linting by default
let g:ale_enabled = 0
