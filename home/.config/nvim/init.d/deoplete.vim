" Check to make sure deoplete in installed before proceeding with initialization
if dein#tap('deoplete.nvim')
  set completeopt-=preview
  let g:deoplete#enable_at_startup = 1
  let g:autocomplete_flow#insert_paren_after_function = 0

  call deoplete#custom#option('sources', {
        \ 'javascript': ['flow', 'neosnippet', 'buffer', 'file'],
        \ 'javascript.jsx': ['flow', 'neosnippet', 'buffer', 'file'],
        \})
endif
