let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-diagnostic',
  \ 'coc-flow',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-prettier',
  \ 'coc-rls',
  \ 'coc-sh',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ ]

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

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList -A grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" coc-settings.json uses jsonc, which adds comment syntax
autocmd FileType json syntax match Comment +\/\/.\+$+"
