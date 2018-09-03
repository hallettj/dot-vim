" settings for w0rp/ale

" I want to disable xml linting while I am working with Salesforce's DTD-less
" XML file formats.
let g:ale_linters = {
      \ 'javascript': [],
      \ 'go': ['gometalinter'],
      \ 'typescript': ['tslint'],
      \ 'xml': [],
      \}

let g:ale_fixers = {
      \ 'go': ['gofmt', 'goimports'],
      \ 'javascript': [],
      \ 'typescript': ['tslint'],
      \}

" options for golang
let g:ale_go_gometalinter_executable = 'gometalinter.v2'
let g:ale_go_gometalinter_options = '--fast'

endif
