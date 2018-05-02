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
  call dein#add('justinmk/vim-dirvish') " file browser to replace netrw
  call dein#add('airblade/vim-rooter') " set working directory based on `.git/`
  call dein#add('simnalamburt/vim-mundo') " UI for navigating undo history
  if has('nvim') && has('python3')
    call dein#add('Shougo/denite.nvim') " general-purpose fuzzy finder
    call dein#add('neoclide/denite-git') " navigate git commits and staged files with denite
  endif

  call dein#add('tpope/vim-unimpaired') " shortcuts for cycling/toggling different things
  call dein#add('tpope/vim-characterize') " show information about character under cursor
  call dein#add('tpope/vim-commentary') " manipulate code comments
  call dein#add('tpope/vim-eunuch') " commands for manipulating files and directories
  call dein#add('tpope/vim-repeat') " makes the `.` command work with third-party actions
  call dein#add('tpope/vim-rsi') " add Emacs-like shortcuts to command mode
  call dein#add('AndrewRadev/splitjoin.vim') " `gS` and `gJ` commands split or join lines

  " Movements
  call dein#add('tpope/vim-surround') " `ds`, `cs`, `ys`, and `S` commands manage delimiters
  call dein#add('justinmk/vim-sneak') " `s` command jumps to occurrence of a pair of characters
  call dein#add('wellle/targets.vim') " more options for movements like `i` and `a`

  " Text objects
  call dein#add('kana/vim-textobj-user') " dependency for third-party text objects
  call dein#add('kana/vim-textobj-entire') " `ae`: entire buffer, `ie`: excludes empty lines
  call dein#add('kana/vim-textobj-function') " `af`, `if`, `aF`, `iF` operate on functions
  call dein#add('kana/vim-textobj-line') " `al`: entire line, `il` excludes whitespace
  call dein#add('coderifous/textobj-word-column.vim') " `ac`, `ic`, `aC`, `iC` select columns

  " more from kana
  call dein#add('kana/vim-niceblock') " makes `I` and `A` work in line-wise visual mode

  " Code completion
  if has('nvim') && has('python3')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('wokalski/autocomplete-flow')
    call dein#add('zchee/deoplete-go', {'build': 'make', 'on_ft': ['go']})
    call dein#add('eagletmt/neco-ghc')
  endif

  " Writing assistance
  call dein#add('kana/vim-smartinput') " automatically closes delimiters as they are typed
  call dein#add('godlygeek/tabular')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')

  " git integration
  call dein#add('neoclide/vim-easygit') " used by denite-git
  call dein#add('tpope/vim-fugitive') " used by vim-rhubarb
  call dein#add('tpope/vim-rhubarb') " provides Github integration

  " Language support
  call dein#add('pangloss/vim-javascript', {'on_ft': ['javascript', 'jsx']})
  call dein#add('mxw/vim-jsx', {'on_ft': ['javascript', 'jsx']})
  call dein#add('flowtype/vim-flow', {'on_ft': ['javascript', 'jsx']})
  call dein#add('maksimr/vim-jsbeautify', {'on_ft': ['javascript', 'jsx']})
  call dein#add('tpope/vim-markdown', {'on_ft': ['md', 'markdown']})
  call dein#add('lambdatoast/elm.vim', {'on_ft': ['elm']})
  call dein#add('idris-hackers/idris-vim', {'on_ft': ['idr']})
  call dein#add('rust-lang/rust.vim', {'on_ft': ['rs']})
  call dein#add('derekwyatt/vim-scala', {'on_ft': ['scala']})
  call dein#add('vim-pandoc/vim-pandoc', {'on_ft': ['md', 'markdown']})
  call dein#add('vim-pandoc/vim-pandoc-syntax', {'on_ft': ['md', 'markdown']})
  call dein#add('leafgarland/typescript-vim', {'on_ft': ['ts', 'typescript']})
  call dein#add('fatih/vim-go', {'on_ft': ['go']})

  " Formatting
  call dein#add('hallettj/vim-sleuth') " configures tab and indent per-file based on nearby files
  call dein#add('sbdchd/neoformat') " reformats code using external formatter

  " Visuals
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('JulioJu/neovim-qt-colors-solarized-truecolor-only')
  call dein#add('drmikehenry/vim-fontdetect')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  if has('nvim')
    call dein#add('machakann/vim-highlightedyank') " highlight text after it has been yanked
  endif

  " Tmux integration
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('hallettj/tmux-config')
  call dein#add('tpope/vim-tbone')

  call dein#add('907th/vim-auto-save')
  call dein#add('mtth/scratch.vim')

  call dein#add('w0rp/ale')

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

if has('gui_running')
  " Remove menu bar, toolbar, and scrollbars
  set guioptions+=mTLlRrb
  set guioptions-=mTLlRrb

  " Overridden in airline customization
  set guifont=Ubuntu\ Mono\ 12
endif

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
