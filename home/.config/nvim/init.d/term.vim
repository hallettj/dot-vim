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

" To simulate |i_CTRL-R| in terminal-mode: >
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Neovim terminal
tnoremap <silent> <ESC><ESC> <C-\><C-n>:let b:was_in_insert = 0<cr>

func! s:maybeInsertMode() abort
  let shouldInsert = !exists('b:was_in_insert') || b:was_in_insert
  if shouldInsert
    startinsert
  endif
endfunc

" Get the exit status from a terminal buffer by looking for a line near the end
" of the buffer with the format, '[Process exited ?]'.
func! s:getExitStatus() abort
  let ln = line('$')
  " The terminal buffer includes several empty lines after the 'Process exited'
  " line that need to be skipped over.
  while ln >= 1
    let l = getline(ln)
    let ln -= 1
    let exitCode = substitute(l, '^\[Process exited \([0-9]\+\)\]$', '\1', '')
    if l != '' && l == exitCode
      " The pattern did not match, and the line was not empty. It looks like
      " there is no process exit message in this buffer.
      break
    elseif exitCode != ''
      return str2nr(exitCode)
    endif
  endwhile
  throw 'Could not determine exit status for buffer, ' . expand('%')
endfunc

func! s:afterTermClose() abort
  if s:getExitStatus() == 0
    bdelete!
  endif
endfunc

augroup MyNeoterm
  autocmd!
  autocmd BufEnter * if &buftype == 'terminal' | call <sid>maybeInsertMode() | endif
  " The line '[Process exited ?]' is appended to the terminal buffer after the
  " `TermClose` event. So we use a timer to wait a few milliseconds to read the
  " exit status. Setting the timer to 0 or 1 ms is not sufficient; 20 ms seems
  " to work for me.
  autocmd TermClose * call timer_start(20, { -> s:afterTermClose() })
augroup END
