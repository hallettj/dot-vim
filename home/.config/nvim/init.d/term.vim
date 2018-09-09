func! s:navigateFromTerminal(direction)
  let b:was_in_insert = 1
  stopinsert
  if a:direction == 'left'
    TmuxNavigateLeft
  elseif a:direction == 'down'
    TmuxNavigateDown
  elseif a:direction == 'right'
    TmuxNavigateRight
  elseif a:direction == 'up'
    TmuxNavigateUp
  endif
endfunc

tnoremap <silent> <C-h> <C-\><C-n>:call <sid>navigateFromTerminal('left')<cr>
tnoremap <silent> <C-j> <C-\><C-n>:call <sid>navigateFromTerminal('down')<cr>
tnoremap <silent> <C-l> <C-\><C-n>:call <sid>navigateFromTerminal('right')<cr>
tnoremap <silent> <C-k> <C-\><C-n>:call <sid>navigateFromTerminal('up')<cr>

" Neovim terminal
tnoremap <silent> <ESC><ESC> <C-\><C-n>:let b:was_in_insert = 0<cr>

func! s:maybeInsertMode()
  let shouldInsert = !exists('b:was_in_insert') || b:was_in_insert
  if shouldInsert
    startinsert
  endif
endfunc

augroup MyNeoterm
  autocmd!
  autocmd BufEnter * if &buftype == 'terminal' | call <sid>maybeInsertMode() | endif
augroup END

" To simulate |i_CTRL-R| in terminal-mode: >
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
