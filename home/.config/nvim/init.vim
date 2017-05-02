" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" set vim home directory as vimrc is sourced
let $VIMFILES=fnamemodify(globpath(&rtp, 'bundle'), ":h")
let $DEIN_PATH=expand('~/.cache/dein')
let $DEIN_REPO=$DEIN_PATH.'/repos/github.com/Shougo/dein.vim'

if has('vim_starting')
  set nocompatible          " We're running Vim, not Vi!
  set runtimepath+=$DEIN_REPO
endif

set shell=/bin/bash

if dein#load_state($DEIN_PATH)
  call dein#begin($DEIN_PATH)

  " Let dein manage dein
  call dein#add($DEIN_REPO)

  if !has('nvim')
    call dein#add('Shougo/vimproc', {'build': 'make'})
  endif

  call dein#add('tpope/vim-sensible')

  " Navigation
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('justinmk/vim-dirvish')
  call dein#add('airblade/vim-rooter')
  call dein#add('tpope/vim-projectionist')

  " unimpaired pairs well with syntastic - provides location list
  " shortcuts
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-characterize')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-dispatch')
  call dein#add('tpope/vim-eunuch')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-rsi')
  call dein#add('AndrewRadev/splitjoin.vim')

  " Movements
  call dein#add('tpope/vim-surround')
  call dein#add('justinmk/vim-sneak')
  call dein#add('wellle/targets.vim')

  " Text objects
  call dein#add('kana/vim-textobj-user')
  call dein#add('kana/vim-textobj-entire')
  call dein#add('kana/vim-textobj-function')
  call dein#add('kana/vim-textobj-line')
  call dein#add('coderifous/textobj-word-column.vim')

  " more from kana
  call dein#add('kana/vim-smartinput')
  call dein#add('kana/vim-niceblock')

  " https://www.gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/
  if has('nvim') && has('python3')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('steelsojka/deoplete-flow', {'on_ft': ['javascript']})
    call dein#add('zchee/deoplete-go', {'build': 'make', 'on_ft': ['go']})
    call dein#add('eagletmt/neco-ghc')
  endif
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')

  call dein#add('tpope/vim-fugitive')
  call dein#add('godlygeek/tabular')

  " Language support
  call dein#add('pangloss/vim-javascript', {'on_ft': ['javascript', 'jsx']})
  call dein#add('mxw/vim-jsx', {'on_ft': ['javascript', 'jsx']})
  call dein#add('maksimr/vim-jsbeautify', {'on_ft': ['javascript', 'jsx']})
  call dein#add('tpope/vim-markdown')
  call dein#add('lambdatoast/elm.vim')
  call dein#add('idris-hackers/idris-vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('derekwyatt/vim-scala', {'on_ft': ['scala']})
  call dein#add('dag/vim-fish', {'on_ft': ['fish']})
  call dein#add('vim-pandoc/vim-pandoc')
  call dein#add('vim-pandoc/vim-pandoc-syntax')
  call dein#add('jparise/vim-graphql')
  call dein#add('leafgarland/typescript-vim')

  " Formatting
  call dein#add('hallettj/vim-sleuth')
  call dein#add('sbdchd/neoformat')

  " Visuals
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('drmikehenry/vim-fontdetect')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  if has('nvim')
    call dein#add('machakann/vim-highlightedyank')
  endif

  " Tmux integration
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('hallettj/tmux-config')
  call dein#add('tpope/vim-tbone')

  call dein#add('vim-scripts/vim-auto-save')
  call dein#add('vim-scripts/gitignore')
  call dein#add('mtth/scratch.vim')

  call dein#add('benekastah/neomake')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

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

" Ask vim-sleuth to respect the 4-space tabstop setting
let g:SleuthDefaultWidth = &tabstop

" Displays visible characters for tab and end-of-line characters.
if has('gui_running')
  " do nothing
else
  set t_ZH=[3m
  set t_ZR=[23m
endif
set listchars=tab:▸\ ,trail:·
set conceallevel=0 concealcursor=c

" Highlights the given column.
set colorcolumn=80

" Store temp files in a central location
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set wildignore+=**/target,*.class,*.jar,*.o,*.hi,*/node_modules/*

if has('gui_running')
  " Remove menu bar, toolbar, and scrollbars
  set guioptions+=mTLlRrb
  set guioptions-=mTLlRrb

  " Overridden in airline customization
  set guifont=Ubuntu\ Mono\ 12
endif

" Reduce time to, e.g., CursorHold event
set updatetime=750

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
  let g:ctrlp_extensions = [ 'mixed', 'quickfix', 'undo' ]
  let g:ctrlp_cmd='CtrlPMixed'
  let g:ctrlp_clear_cache_on_exit=1
  let g:ctrlp_max_height=40
  let g:ctrlp_show_hidden=0
  let g:ctrlp_follow_symlinks=1
  let g:ctrlp_working_path_mode='a'
  let g:ctrlp_max_files=1000
  let g:ctrlp_max_depth=10
  let g:ctrlp_cache_dir=$VIMFILES.'/.cache/ctrlp'
  let g:ctrlp_mruf_relative = 1
  if executable('ag')
    let g:ctrlp_user_command = 'ag %s --nocolor -g ""'
  endif
"}}}

" tpope/vim-fugitive {{{
  autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
  autocmd FileType dirvish call fugitive#detect(@%)
"}}}

" airblaide/vim-gitgutter {{{
  let g:gitgutter_enabled = 0
"}}}

" vim-pandoc/vim-pandoc {{{
  let g:pandoc#modules#disabled = ["chdir"]
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
