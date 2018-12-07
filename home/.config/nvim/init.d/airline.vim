" settings for vim-airline/vim-airline

set noshowmode  " Mode is indicated in status line instead.

let g:airline_powerline_fonts = 1

let g:airline#extensions#languageclient#error_symbol = ''
let g:airline#extensions#languageclient#warning_symbol = ''

let g:airline#extensions#coc#error_symbol = ''
let g:airline#extensions#coc#warning_symbol = ''

call airline#parts#define_empty(['coc_error_count', 'coc_warning_count'])
let g:airline_section_error = airline#section#create(['coc_error_count', 'ale_error_count'])
let g:airline_section_warning = airline#section#create(['coc_warning_count', 'ale_warning_count'])

" certain number of spaces are allowed after tabs, but not in between
let g:airline#extensions#whitespace#mixed_indent_algo = 1

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'solarized' && &background == 'dark'
    for colors in values(a:palette.normal)
      call ReplaceWhiteForegroundColors(colors)
    endfor
    for colors in values(a:palette.insert)
      call ReplaceWhiteForegroundColors(colors)
    endfor
    for colors in values(a:palette.visual)
      call ReplaceWhiteForegroundColors(colors)
    endfor
  endif
endfunction

" Change bright-white foreground colors in airline palettes to base02.
function! ReplaceWhiteForegroundColors(colors)
  let l:base02 = {'t':  0, 'g': '#073642'}
  let l:base2  = {'t':  7, 'g': '#eee8d5'}
  let l:base3  = {'t': 15, 'g': '#fdf6e3'}

  " replace gui colors
  if a:colors[0] == l:base3.g
    let a:colors[0] = l:base02.g
  elseif a:colors[0] == l:base2.g
    let a:colors[0] = l:base02.g
  endif

  " replace term colors
  if a:colors[2] == l:base3.t
    let a:colors[2] = l:base02.t
  elseif a:colors[2] == l:base2.t
    let a:colors[2] = l:base02.t
  endif
endfunction
