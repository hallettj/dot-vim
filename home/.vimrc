" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  set nocompatible          " We're running Vim, not Vi!
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {'build': {'unix': 'make'}}
NeoBundle 'tpope/vim-sensible'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'majutsushi/tagbar', { 'depends': 'bitc/lushtags' }

" unimpaired pairs well with syntastic - provides location list
" shortcuts
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-characterize'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'IndentAnything'

" Movements
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'wellle/targets.vim'
NeoBundle 'terryma/vim-expand-region'

NeoBundle 'Valloric/YouCompleteMe', { 'build': { 'unix': './install.sh' }}
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Raimondi/delimitMate'

NeoBundle 'pangloss/vim-javascript'
NeoBundle 'marijnh/tern_for_vim', { 'build': { 'unix': 'npm install' } }
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'kchmck/vim-coffee-script'

NeoBundle 'lambdatoast/elm.vim'

NeoBundle 'Twinside/vim-haskellConceal'
NeoBundle 'idris-hackers/idris-vim'
NeoBundle 'japesinator/vim-IdrisConceal'

NeoBundle 'benmills/vimux'
NeoBundle 'jpalardy/vim-slime'

NeoBundle 'sotte/presenting.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'rking/ag.vim'
NeoBundle 'drmikehenry/vim-fontdetect'

NeoBundle 'bling/vim-airline'

NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'hallettj/tmux-config'
NeoBundle 'tpope/vim-tbone'

NeoBundle 'vim-scripts/gitignore'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Map <Leader> to , key
let mapleader = " "
let maplocalleader = "  "

set encoding=utf-8
set scrolloff=3
set wildmode=longest
set ttyfast

" Fixes H and L movements for use with scrolloff
execute 'nnoremap H H'.&l:scrolloff.'k'
execute 'vnoremap H H'.&l:scrolloff.'k'
execute 'nnoremap L L'.&l:scrolloff.'j'
execute 'vnoremap L L'.&l:scrolloff.'j'

" Make searches case-sensitive only when capital letters are included.
set ignorecase
set smartcase

" Wrap long lines
set wrap
set textwidth=80
set formatoptions=cqrn1

" Default indentation options
set tabstop=4
set shiftwidth=4
set noexpandtab

" Displays visible characters for tab and end-of-line characters.
if has('gui_running')
  set list
else
  set t_ZH=[3m
  set t_ZR=[23m
endif
set listchars=tab:▸\ ,eol:¬
set conceallevel=0 concealcursor=n

" Highlights the given column.
set colorcolumn=80

" Store temp files in a central location
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set wildignore+=**/target,*.class,*.jar,*.o,*.hi

if has('gui_running')
  " Remove menu bar, toolbar, and scrollbars
  set guioptions+=mTLlRrb
  set guioptions-=mTLlRrb

  " Overridden in airline customization
  set guifont=Ubuntu\ Mono\ 12
endif

" Automatically save when the window loses focus or when a buffer is
" hidden.
set autowriteall
set autoread
set hidden
au FocusLost * silent! wall

" Don't keep swap files.
set noswapfile
set nobackup
set writebackup

" Load matchit to bounce between do and end in Ruby and between opening
" and closing tags in HTML.
if !has('gui_running')
  set noshowmatch
  let loaded_matchparen = 1  " Prevents DoMatchParen plugin from loading.
endif

" I don't want code to be folded when I open a file.
set nofoldenable

" Swap : and ,
nnoremap , :
vnoremap , :
nnoremap : ,
vnoremap : ,

" Bounce between bracket pairs with the <tab> key.
nnoremap <tab> %
vnoremap <tab> %

" Swaps ' and `
nnoremap ' `
vnoremap ' `
nnoremap ` '
vnoremap ` '

" Retains selection in visual mode when indenting blocks
vnoremap < <gv
vnoremap > >gv

" Makes Vim's visual mode more consistent with tmux's
vnoremap <Enter> y

" Window management shortcuts
nnoremap <C-_> <C-w>_

" System copy/paste shortcuts
" These come from:
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Scratch buffer shortcuts
nnoremap <Leader>s :Svsplit<cr>
nnoremap <Leader>S :Ssplit<cr>

" cd to directory of current file
nnoremap <Leader>cd :cd %:p:h<cr>

" Commands to create scratch buffers
function! s:scratchEdit(cmd, options)
    exe a:cmd tempname()
    setl buftype=nofile bufhidden=wipe nobuflisted
    if !empty(a:options) | exe 'setl' a:options | endif
endfunction
command! -bar -nargs=* Sedit    call s:scratchEdit('edit',   <q-args>)
command! -bar -nargs=* Ssplit   call s:scratchEdit('split',  <q-args>)
command! -bar -nargs=* Svsplit  call s:scratchEdit('vsplit', <q-args>)
command! -bar -nargs=* Stabedit call s:scratchEdit('tabe',   <q-args>)

" Use ranger as vim file manager
function! Ranger()
    " Get a temp file name without creating it
    let tmpfile = substitute(system('mktemp -u'), '\n', '', '')
    " Launch ranger, passing it the temp file name
    silent exec '!RANGER_RETURN_FILE='.tmpfile.' ranger'
    " If the temp file has been written by ranger
    if filereadable(tmpfile)
        " Get the selected file name from the temp file
        let filetoedit = system('cat '.tmpfile)
        exec 'edit '.filetoedit
        call delete(tmpfile)
    endif
    redraw!
endfunction

nmap <leader>r :call Ranger()<cr>

" kien/ctrlp.vim {{{
  let g:ctrlp_cmd='CtrlP'
  let g:ctrlp_clear_cache_on_exit=1
  let g:ctrlp_max_height=40
  let g:ctrlp_show_hidden=0
  let g:ctrlp_follow_symlinks=1
  let g:ctrlp_working_path_mode='a'
  let g:ctrlp_max_files=60000
  let g:ctrlp_cache_dir='~/.vim/.cache/ctrlp'

  nnoremap <leader>f :CtrlP getcwd()<CR>
  nnoremap <leader>b :CtrlPBuffer<CR>
  nnoremap <leader>T :CtrlPBufTag<CR>
  nnoremap <leader>t :CtrlPTag<CR>
  nnoremap <leader>F :CtrlPRoot<CR>
  nnoremap <leader>M :CtrlPMRUFiles<CR>
  nnoremap <leader>m :CtrlPMixed<CR>
  nnoremap <leader>l :CtrlPLine<CR>
"}}}

" tpope/vim-fugitive {{{
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap          <leader>ge :Gedit<space>
  nnoremap <silent> <leader>gl :silent Glog<CR>:copen<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
  autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
  autocmd BufReadPost fugitive://* set bufhidden=delete
"}}}

" mhinz/vim-signify {{{
  let g:signify_disable_by_default = 1
  let g:signify_mapping_next_hunk = '<leader>gj'
  let g:signify_mapping_prev_hunk = '<leader>gk'
  let g:signify_mapping_toggle_highlight = '<leader>gh'
  let g:signify_mapping_toggle           = '<leader>gt'
"}}}

" scrooloose/syntastic {{{
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_style_error_symbol = '✠'
  let g:syntastic_warning_symbol = '∆'
  let g:syntastic_style_warning_symbol = '≈'
  let g:syntastic_enable_signs=0
  nnoremap <silent> <Leader>e :SyntasticCheck<cr>:silent! Errors<cr>
  vnoremap <silent> <Leader>e :SyntasticCheck<cr>:silent! Errors<cr>
  " nnoremap <silent> <leader>lc :lclose<cr>:cclose<cr>
  " nnoremap <silent> <leader>lo :lopen<cr>
  nnoremap <silent> <leader>cc :cclose<cr>:lclose<cr>
  nnoremap <silent> <leader>co :copen<cr>
"}}}

" majutsushi/tagbar {{{
  nnoremap <silent> <Leader>] :TagbarToggle<cr>
  vnoremap <silent> <Leader>] :TagbarToggle<cr>
"}}}

" Valloric/YouCompleteMe {{{
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1

  " Disables autocompletion for certain filetypes.  I find it annoying
  " when writing prose.
  let g:ycm_filetype_blacklist = {
    \ 'tex':      1,
    \ 'markdown': 1,
    \ 'mail':     1
    \ }
"}}}

" pangloss/vim-javascript {{{
  if has('conceal')
    let g:javascript_conceal=1
    autocmd FileType javascript set conceallevel=2 concealcursor=n
  endif
"}}}

" marijnh/tern_for_vim {{{
  augroup Tern
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <silent> <leader>td :TernDef<cr>
    autocmd FileType javascript nnoremap <buffer> <silent> <leader>tD :TernDefSplit<cr>
    autocmd FileType javascript nnoremap <buffer> <silent> <leader>tr :TernRefs<cr>
    autocmd FileType javascript nnoremap <buffer> <silent> <leader>tc :TernRename<cr>
  augroup END
"}}}

" maksimr/vim-jsbeautify {{{
  nnoremap <leader>js :call JsBeautify()<cr>
"}}}

" kchmck/vim-coffee-script {{{
  " Disable error highlighting on trailing spaces
  hi link coffeeSpaceError None
"}}}

" jpalardy/vim-slime {{{
  " Run slime.vim sessions in tmux
  let g:slime_target = "tmux"
"}}}

" altercation/vim-colors-solarized {{{
  set background=dark
  set t_Co=16
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
"}}}

" rking/ag.vim {{{
  nnoremap <leader>a :Ag<space>
  vnoremap <leader>a "*y:Ag<space>'<C-R>*'<CR>
"}}}

" bling/vim-airline {{{
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
"}}}

" SirVer/ultisnips {{{
  let g:UltiSnipsEditSplit = 'vertical'
  "let g:UltiSnipsExpandTrigger = '<C-j>'

  " Allows the same trigger to operate UltiSnips and YouCompleteMe
  function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
      if pumvisible()
        return "\<C-n>"
      else
        call UltiSnips#JumpForwards()
        if g:ulti_jump_forwards_res == 0
          return "\<TAB>"
        endif
      endif
    endif
    return ""
  endfunction

  au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
  "let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsListSnippets="<c-e>"
"}}}

" Raimondi/delimitMate {{{
  let delimitMate_expand_cr          = 1
  let delimitMate_expand_space       = 1
  let delimitMate_balance_matchpairs = 1
  let delimitMate_jump_expansion     = 1
"}}}

" terryma/vim-expand-region {{{
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
"}}}
