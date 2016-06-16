" settings for vim-airline/vim-airline
let g:airline_solarized_bg = 'dark'
let g:airline_theme = 'hallettj_solarized'

" settings for bling/vim-airline
if fontdetect#hasFontFamily('Ubuntu Mono derivative Powerline')
  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12,Ubuntu\ Mono\ 12,DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  let g:airline_powerline_fonts = 1
else
  let g:airline_powerline_fonts = 0
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇ '
  let g:airline_symbols.whitespace = 'Ξ'
endif
set noshowmode  " Mode is indicated in status line instead.

" certain number of spaces are allowed after tabs, but not in between
let g:airline#extensions#whitespace#mixed_indent_algo = 1
