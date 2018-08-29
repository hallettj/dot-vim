" Automatically save when the window loses focus or when a buffer is
" hidden.
set autoread
set hidden

" Don't keep swap files.
set noswapfile
set nobackup
set writebackup


" Reduce time to, e.g., CursorHold event
set updatetime=300

let g:auto_save = 1
let g:auto_save_write_all_buffers = 1
let g:auto_save_events = ["BufLeave", "CursorHold", "FocusLost"]

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
