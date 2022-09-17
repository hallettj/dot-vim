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

" We need to apply the colorscheme synchronously during startup - otherwise
" Treesitter highlight groups get linked to generic group names. See notes in
" config/colorscheme-catppuccin.lua. 
colorscheme catppuccin
