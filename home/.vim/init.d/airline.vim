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

let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 98,
  \ 'x': 60,
  \ 'y': 98,
  \ 'z': 45,
  \ }

" Customizes airline theme to reduce contrast
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  let ansi_colors = get(g:, 'solarized_termcolors', 16) != 256 && &t_Co >= 16 ? 1 : 0
  let tty         = &t_Co == 8
  let base03  = {'t': ansi_colors ?   8 : (tty ? '0' : 234), 'g': '#002b36'}
  let base02  = {'t': ansi_colors ? '0' : (tty ? '0' : 235), 'g': '#073642'}
  let base01  = {'t': ansi_colors ?  10 : (tty ? '0' : 240), 'g': '#586e75'}
  let base00  = {'t': ansi_colors ?  11 : (tty ? '7' : 241), 'g': '#657b83'}
  let base0   = {'t': ansi_colors ?  12 : (tty ? '7' : 244), 'g': '#839496'}
  let base1   = {'t': ansi_colors ?  14 : (tty ? '7' : 245), 'g': '#93a1a1'}
  let base2   = {'t': ansi_colors ?   7 : (tty ? '7' : 254), 'g': '#eee8d5'}
  let base3   = {'t': ansi_colors ?  15 : (tty ? '7' : 230), 'g': '#fdf6e3'}
  let yellow  = {'t': ansi_colors ?   3 : (tty ? '3' : 136), 'g': '#b58900'}
  let orange  = {'t': ansi_colors ?   9 : (tty ? '1' : 166), 'g': '#cb4b16'}
  let red     = {'t': ansi_colors ?   1 : (tty ? '1' : 160), 'g': '#dc322f'}
  let magenta = {'t': ansi_colors ?   5 : (tty ? '5' : 125), 'g': '#d33682'}
  let violet  = {'t': ansi_colors ?  13 : (tty ? '5' : 61 ), 'g': '#6c71c4'}
  let blue    = {'t': ansi_colors ?   4 : (tty ? '4' : 33 ), 'g': '#268bd2'}
  let cyan    = {'t': ansi_colors ?   6 : (tty ? '6' : 37 ), 'g': '#2aa198'}
  let green   = {'t': ansi_colors ?   2 : (tty ? '2' : 64 ), 'g': '#859900'}

  let mode_fg   = base02
  let mode_bg   = base0
  let branch_fg = base02
  let branch_bg = base00
  let middle_fg = base01
  let middle_bg = base02
  let inactive_fg = base01
  let inactive_bg = base02

  " Cheatsheet:
  " airline_a = mode indicator
  " airline_b = branch
  " airline_c = middle (filename)
  " airline_x = filetype & tag
  " airline_y = encoding
  " airline_z = line number / position
  " airline_warning = syntastic & whitespace

  if g:airline_theme == 'solarized'
    let a:palette.normal.airline_a[1] = mode_bg.g
    let a:palette.normal.airline_a[3] = mode_bg.t
    let a:palette.normal.airline_z[1] = mode_bg.g
    let a:palette.normal.airline_z[3] = mode_bg.t
    let a:palette.inactive = airline#themes#generate_color_map(
      \ [inactive_fg.g, inactive_bg.g, inactive_fg.t, inactive_bg.t, ''],
      \ [inactive_fg.g, inactive_bg.g, inactive_fg.t, inactive_bg.t, ''],
      \ [inactive_fg.g, inactive_bg.g, inactive_fg.t, inactive_bg.t, ''])
    for modes in keys(a:palette)
      if modes != 'inactive' && has_key(a:palette[modes], 'airline_a')
        let a:palette[modes]['airline_a'][0] = mode_fg.g
        let a:palette[modes]['airline_a'][2] = mode_fg.t
      endif
      if modes != 'inactive' && has_key(a:palette[modes], 'airline_b')
        let a:palette[modes]['airline_b'][0] = branch_fg.g
        let a:palette[modes]['airline_b'][1] = branch_bg.g
        let a:palette[modes]['airline_b'][2] = branch_fg.t
        let a:palette[modes]['airline_b'][3] = branch_bg.t
      endif
      if modes != 'inactive' && has_key(a:palette[modes], 'airline_c')
        let a:palette[modes]['airline_c'][0] = middle_fg.g
        let a:palette[modes]['airline_c'][1] = middle_bg.g
        let a:palette[modes]['airline_c'][2] = middle_fg.t
        let a:palette[modes]['airline_c'][3] = middle_bg.t
      endif
      if modes != 'inactive' && has_key(a:palette[modes], 'airline_y')
        let a:palette[modes]['airline_y'][0] = branch_fg.g
        let a:palette[modes]['airline_y'][2] = branch_fg.t
        let a:palette[modes]['airline_y'][2] = branch_fg.t
        let a:palette[modes]['airline_y'][3] = branch_bg.t
      endif
      if modes != 'inactive' && has_key(a:palette[modes], 'airline_z')
        let a:palette[modes]['airline_z'][0] = mode_fg.g
        let a:palette[modes]['airline_z'][2] = mode_fg.t
      endif
    endfor
  endif

  highlight VertSplit ctermfg=10 ctermbg=8 gui=reverse
  set fillchars+=vert:│
endfunction
