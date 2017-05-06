set completeopt=longest,menuone

" Check to make sure deoplete in installed before proceeding with initialization
if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:UltiSnipsExpandTrigger = "<C-j>"
  let g:autocomplete_flow#insert_paren_after_function = 0
endif
