set completeopt=longest,menuone

if has('nvim') && has('python3')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#sources#flow#flow_bin = 'flow'

  let g:deoplete#sources = {}
  let g:deoplete#sources['javascript'] = ['ultisnips', 'flow']

  " Configure <tab> behavior
  autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
  let g:UltiSnipsExpandTrigger = "<C-j>"
  inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
endif
