" Remap Enter to save buffer
nnoremap <expr> <silent> <CR> &modifiable ? ":update<CR>" : "<CR>"
