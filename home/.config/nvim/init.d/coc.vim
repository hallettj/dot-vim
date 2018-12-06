if dein#tap('coc.nvim')
  set cmdheight=2
  set signcolumn=yes

  let g:coc_auto_open = 0 " do not open quickfix automatically

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  augroup cocGroup
    autocmd!
    " Close preview window when completion is done.
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  augroup end

  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` for fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
endif
