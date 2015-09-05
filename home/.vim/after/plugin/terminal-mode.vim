" neovim terminal emulator

if has('neovim')
  " shortcut to switch to normal mode
  tnoremap <Leader>e <C-\><C-n>

  tnoremap <C-h> <C-\><C-n><C-w><C-h>
  tnoremap <C-j> <C-\><C-n><C-w><C-j>
  tnoremap <C-k> <C-\><C-n><C-w><C-k>
  tnoremap <C-l> <C-\><C-n><C-w><C-l>

  tnoremap <C-H> <C-\><C-n><C-w><C-H>
  tnoremap <C-J> <C-\><C-n><C-w><C-J>
  tnoremap <C-K> <C-\><C-n><C-w><C-K>
  tnoremap <C-L> <C-\><C-n><C-w><C-L>

  tnoremap <C-_> <C-\><C-n><C-w><C-_>
  tnoremap <C-w> <C-\><C-n><C-w>
endif
