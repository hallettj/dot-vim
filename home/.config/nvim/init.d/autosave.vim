" Automatically save when the window loses focus or when a buffer is
" hidden.
set autoread
set hidden

" Don't keep swap files.
set noswapfile
set nobackup
set writebackup

" Keep backups for writebackup in a central location
set backupdir=~/.local/share/nvim/backup//

" This isn't used since noswapfile is set, but it's here for symmetry
set directory=~/.local/share/nvim/swap//

" Reduce time to, e.g., CursorHold event
set updatetime=300

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_write_all_buffers = 1

augroup my_autosave
  autocmd!

  " Save files automatically. This applies to individual buffers. For example on
  " FocusLost the autocmd only triggers on the window that was focused when the
  " editor as a whole lost focus.
  "autocmd BufLeave,FocusLost * silent update

  " Unfortunately saving frequently causes too much churn for
  " haskell-language-server in large projects.
  "autocmd FileType haskell let b:auto_save = 0

  " Triger `autoread` when files changes on disk
  " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
  " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
  autocmd FocusGained,BufEnter * if mode() != 'c' | checktime | endif

  " Notification after file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
