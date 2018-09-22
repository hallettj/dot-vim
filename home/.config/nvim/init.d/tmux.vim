let g:tmux_navigator_disable_when_zoomed = 1

" Tmux functions copied from christoomey/vim-tmux-navigator
function! s:TmuxOrTmateExecutable()
  return (match($TMUX, 'tmate') !=? -1 ? 'tmate' : 'tmux')
endfunction

function! s:TmuxSocket()
  " The socket path is the first value in the comma-separated list of $TMUX.
  return split($TMUX, ',')[0]
endfunction

function! s:TmuxCommand(args)
  let cmd = s:TmuxOrTmateExecutable() . ' -S ' . s:TmuxSocket() . ' ' . a:args
  return system(cmd)
endfunction

function! s:TmuxVimPaneIsZoomed()
  return s:TmuxCommand("display-message -p '#{window_zoomed_flag}'") == 1
endfunction

function! s:int2float(n)
  return a:n * 1.0
endfunction

" Returns the with of the tmux client window. If you have tmux windows
" side-by-side then this will be bigger than the column width of each pane
" (`&columns`).
function! s:ClientWidth()
  return str2nr(s:TmuxCommand('display-message -p -F "#{client_width}"'), 10)
endfunction

" Assumes that Vim windows have equal widths.
function! s:VertSplitCount()
  let restoreCommands = split(winrestcmd(), '|')
  let verticalCommands = filter(restoreCommands, { idx, cmd -> cmd =~# 'vert' })
  let widthStrings = map(verticalCommands, { idx, cmd -> substitute(cmd, '^.\{-}\(\d\+\)$', '\1', '') })
  let windowWidths = map(widthStrings, { idx, str -> str2nr(str) })
  let floatCount = &columns / s:int2float(min(windowWidths))
  return float2nr(round(floatCount))
endfunction

function! s:SetWindowsToEqualWidths()
  let restoreCommands = split(winrestcmd(), '|')
  let heightCommands = filter(restoreCommands, { idx, cmd -> cmd =~# '^\d\+resize' })
  wincmd =
  execute join(heightCommands, '|')
endfunction

" This function resizes the Tmux pane containing Vim to evenly allocate width
" between Vim's vertical splits and one additional Tmux window.
function! s:SetPaneWidth()
  if s:TmuxVimPaneIsZoomed()
    return
  endif
  " Compute number of vertical splits assuming windows have equal widths.
  let vimColCount = s:VertSplitCount()
  let targetWidth = vimColCount * (s:ClientWidth() / (vimColCount + 1))
  " Allow for a margin of one column to accommodate rounding issues.
  if abs(targetWidth - &columns) > 1
    call s:TmuxCommand('resize-pane -t ' . $TMUX_PANE . ' -x ' . targetWidth)
  endif
endfunction

augroup TmuxDynamicPaneSize
  autocmd!
  if !empty($TMUX)
    " Use `timer_start` so that vim can update window sizes before we update the
    " pane width.
    autocmd BufWinLeave,WinLeave,WinNew * call timer_start(10, { -> s:SetPaneWidth() })
    autocmd VimResized * call <SID>SetWindowsToEqualWidths() | call <SID>SetPaneWidth()
  endif
augroup END

function! s:ActivateTerminalPane()
  call s:TmuxCommand('select-pane -l')
endfunction

command! ActivateTerminalPane call s:ActivateTerminalPane()
