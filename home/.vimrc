" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" set vim home directory as vimrc is sourced
let $VIMFILES=fnamemodify(globpath(&rtp, 'bundle'), ":h")

if has('vim_starting')
  set nocompatible          " We're running Vim, not Vi!
  set runtimepath+=$VIMFILES/bundle/neobundle.vim/
endif

call neobundle#begin($VIMFILES.'/bundle/')

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {'build': {'unix': 'make'}}
NeoBundle 'tpope/vim-sensible'

" Navigation
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'justinmk/vim-dirvish'
NeoBundle 'rking/ag.vim'

" unimpaired pairs well with syntastic - provides location list
" shortcuts
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-characterize'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-surround'

NeoBundle 'AndrewRadev/splitjoin.vim'

" Movements
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'wellle/targets.vim'

" Text objects
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'glts/vim-textobj-comment'

if has('nvim') && has('python3')
  NeoBundle 'Shougo/deoplete.nvim'
endif
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'godlygeek/tabular'

" Language support
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'lambdatoast/elm.vim'
NeoBundle 'idris-hackers/idris-vim'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mtscout6/vim-cjsx'
NeoBundle 'dag/vim-fish'
NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'vim-pandoc/vim-pandoc-syntax'

" Visuals
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'drmikehenry/vim-fontdetect'
NeoBundle 'bling/vim-airline'

" Tmux integration
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'hallettj/tmux-config'
NeoBundle 'tpope/vim-tbone'

NeoBundle 'vim-scripts/vim-auto-save'
NeoBundle 'vim-scripts/gitignore'
NeoBundle 'mtth/scratch.vim'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Don't need netrw - we are using dirvish instead
let g:loaded_netrwPlugin = 1

set encoding=utf-8
set scrolloff=3
set wildmode=longest
if has ('ttyfast')
  set ttyfast
endif

" Make searches case-sensitive only when capital letters are included.
set ignorecase
set smartcase
set nohlsearch

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
let g:auto_save = 1
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
let g:tmux_navigator_save_on_switch = 1

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

" kien/ctrlp.vim {{{
  let g:ctrlp_cmd='CtrlP'
  let g:ctrlp_clear_cache_on_exit=1
  let g:ctrlp_max_height=40
  let g:ctrlp_show_hidden=0
  let g:ctrlp_follow_symlinks=1
  let g:ctrlp_working_path_mode='a'
  let g:ctrlp_max_files=60000
  let g:ctrlp_cache_dir=$VIMFILES.'/.cache/ctrlp'
"}}}

" tpope/vim-fugitive {{{
  autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
  autocmd FileType dirvish call fugitive#detect(@%)
"}}}

" airblaide/vim-gitgutter {{{
  let g:gitgutter_enabled = 0
"}}}

" scrooloose/syntastic {{{
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_style_error_symbol = '✠'
  let g:syntastic_warning_symbol = '∆'
  let g:syntastic_style_warning_symbol = '≈'
  let g:syntastic_enable_signs=0
"}}}

" Shougo/deoplete {{{
  if has('nvim') && has('python3')
    let g:deoplete#enable_at_startup = 1
  endif
"}}}

" vim-pandoc/vim-pandoc {{{
  let g:pandoc#modules#disabled = ["chdir"]
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

" Raimondi/delimitMate {{{
  let delimitMate_expand_cr          = 1
  let delimitMate_expand_space       = 1
  let delimitMate_balance_matchpairs = 1
  let delimitMate_jump_expansion     = 1
"}}}

if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") && &filetype != 'gitcommit' | exe "'\"" | endif
endif

runtime! init.d/*.vim
