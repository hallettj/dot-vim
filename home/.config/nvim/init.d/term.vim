" To simulate |i_CTRL-R| in terminal-mode: >
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Key binding to enter normal mode in a terminal
tnoremap <silent> <C-b> <C-\><C-n>

augroup MyNeoterm
  autocmd!
  autocmd TermOpen * setlocal signcolumn=auto
augroup END

" If vim is running in a tmux split these bindings allow navigating to and from
" other tmux splits using the same shortcuts we use to navigate between windows
" within vim.
"
" When running terminals inside neovim these bindings allow the usual window
" navigation shortcuts to work in terminal mode too.
func! s:navigateFromTerminal(direction)
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

" And because we have vim-tmux-navigator configured not to install keybindings,
" let's define the normal mode bindings here.
nnoremap <silent> <C-h> <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-l> <cmd>TmuxNavigateRight<cr>
nnoremap <silent> <C-k> <cmd>TmuxNavigateUp<cr>
