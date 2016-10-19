set completeopt=longest,menuone

" Check to make sure deoplete in installed before proceeding with initialization
if !dein#check_install(['deoplete.nvim'])
  let g:deoplete#enable_at_startup = 1

  let g:deoplete#sources = {}
  let g:deoplete#sources._ = ['buffer']
  let g:deoplete#sources.go = ['ultisnips', 'go']
  let g:deoplete#sources.javascript = ['ultisnips', 'flow']

  " Disable haskell-vim omnifunc
  let g:haskellmode_completion_ghc = 0

  " Configure <tab> behavior
  " autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
  let g:UltiSnipsExpandTrigger = "<C-j>"
  " inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  " Open completions menu on tab if character before cursor is not whitespace;
  " otherwise just send <tab>
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <expr><C-h>
        \ deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>
        \ deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-g>
        \ deoplete#undo_completion()
  inoremap <expr><C-l>
        \ deoplete#refresh()
endif
