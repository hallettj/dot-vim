set noshowcmd

" I don't want code to be folded when I open a file.
set nofoldenable

" Reverse chirality of splits
set splitbelow
set splitright

if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") && &filetype != 'gitcommit' | exe "'\"" | endif
endif

" Nicer diffs
if has('nvim-0.3.2') || has("patch-8.1.0360")
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

colorscheme catppuccin
