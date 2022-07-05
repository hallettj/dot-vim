let g:coc_global_extensions = [
  \ 'coc-calc',
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-flow',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-lua',
  \ 'coc-project',
  \ 'coc-react-refactor',
  \ 'coc-rust-analyzer',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ ]

set completeopt=noinsert,noselect,menuone
set signcolumn=yes

let g:coc_auto_open = 0 " do not open quickfix automatically

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" coc-settings.json uses jsonc, which adds comment syntax
autocmd FileType json syntax match Comment +\/\/.\+$+"
