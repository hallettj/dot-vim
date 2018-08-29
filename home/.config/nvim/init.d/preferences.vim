set noshowcmd

" I don't want code to be folded when I open a file.
set nofoldenable

if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") && &filetype != 'gitcommit' | exe "'\"" | endif
endif
