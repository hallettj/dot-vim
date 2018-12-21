function! s:isPreviewWindowOpen()
  for nr in range(1, winnr('$'))
    if getwinvar(nr, "&pvw") == 1
      return 1
    endif
  endfor
  return 0
endfunction

" Close preview window without changing the sizes of other windows.
function! s:closePreview()
  if !s:isPreviewWindowOpen()
    return
  endif

  let eq = &equalalways
  set noequalalways
  pclose
  if eq
    let cmd = winrestcmd()
    let &equalalways = eq
    exe cmd
  endif
endfunction

nnoremap <silent> <C-W>z :call <SID>closePreview()<cr>

if dein#tap('coc.nvim')
  set cmdheight=2
  set completeopt=noinsert,noselect,menuone
  set signcolumn=yes

  let g:coc_auto_open = 0 " do not open quickfix automatically

  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` for fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)
endif
