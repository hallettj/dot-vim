set background=dark
if has('gui_running')
  " I like the lower contrast for list characters.  But in a terminal
  " this makes them completely invisible and causes the cursor to
  " disappear.
  let g:solarized_visibility="low" "Specifies contrast of invisibles.
endif
colorscheme solarized
highlight SignColumn ctermbg=0 guibg=#002b36
highlight SpecialKey ctermbg=8 ctermfg=10
highlight NonText    ctermbg=8 ctermfg=10
