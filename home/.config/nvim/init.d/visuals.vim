set termguicolors

set background=dark
let g:neosolarized_contrast = "normal"
let g:neosolarized_visibility = "normal"
let g:neosolarized_vertSplitBgTrans = 1
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1

function! s:MySolarizedCustomizations() abort
  highlight CocCodeLens ctermfg=green guifg=green
  highlight CocHighlightText ctermbg=black guibg=black
  highlight CocHintSign ctermfg=green guifg=green
  highlight TermCursor ctermfg=red guifg=red

  " Floating window colors
  highlight NormalFloat ctermfg=none ctermbg=0
  highlight Pmenu cterm=none ctermfg=none ctermbg=0

  " Lightspeed colors
  highlight LightspeedGreyWash ctermfg=12 ctermbg=8 guifg=12 guibg=8
endfunction

augroup MySolarizedCustomizations
  autocmd!
  autocmd ColorScheme NeoSolarized call <SID>MySolarizedCustomizations()
augroup END

colorscheme NeoSolarized
