" Automatically save when the window loses focus or when a buffer is
" hidden.
set autowriteall
set autoread
set hidden

" Reduce time to, e.g., CursorHold event
set updatetime=300

let g:auto_save = 1
let g:auto_save_write_all_buffers = 1
let g:auto_save_events = ["BufLeave", "CursorHold", "FocusLost"]
