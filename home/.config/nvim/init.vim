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

  call dein#add('tpope/vim-sensible')

  " Navigation
  call dein#add('justinmk/vim-dirvish') " file browser to replace netrw
  call dein#add('kristijanhusak/vim-dirvish-git')
  call dein#add('airblade/vim-rooter') " set working directory based on `.git/`
  call dein#add('simnalamburt/vim-mundo') " UI for navigating undo history
  call dein#add('andymass/vim-tradewinds')

  call dein#add('tpope/vim-unimpaired') " shortcuts for cycling/toggling different things
  call dein#add('tpope/vim-characterize') " show information about character under cursor
  call dein#add('tpope/vim-commentary') " manipulate code comments
  call dein#add('tpope/vim-eunuch') " commands for manipulating files and directories
  call dein#add('tpope/vim-repeat') " makes the `.` command work with third-party actions
  call dein#add('tpope/vim-rsi') " add Emacs-like shortcuts to command mode
  call dein#add('AndrewRadev/splitjoin.vim') " `gS` and `gJ` commands split or join lines

  " Movements
  call dein#add('machakann/vim-sandwich') " `ds`, `cs`, `ys`, and `S` commands manage delimiters
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

  " IDE features
  call dein#add('neoclide/coc.nvim', {'rev': 'release'})

  " Writing assistance
  call dein#add('kana/vim-smartinput') " automatically closes delimiters as they are typed
  call dein#add('godlygeek/tabular')

  " git integration
  call dein#add('tpope/vim-fugitive') " used by vim-rhubarb
  call dein#add('tpope/vim-rhubarb') " provides Github integration

  " Language support
  call dein#add('sheerun/vim-polyglot')
  call dein#add('neoclide/jsonc.vim')
  call dein#add('vmchale/just-vim')
  call dein#add('jparise/vim-graphql')
  call dein#add('DeltaWhy/vim-mcfunction')

  " Visuals
  call dein#add('iCyMind/NeoSolarized')
  call dein#add('drmikehenry/vim-fontdetect')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  if has('nvim')
    call dein#add('machakann/vim-highlightedyank') " highlight text after it has been yanked
  endif
  call dein#add('liuchengxu/vim-which-key', { 'on_cmd': ['WhichKey', 'WhichKey!'] })
  call dein#add('psliwka/vim-smoothie')

  " Tmux integration
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('hallettj/tmux-config')
  call dein#add('tpope/vim-tbone')

  " Embedding support
  call dein#add('glacambre/firenvim', { 'hook_post_update': { -> firenvim#install(0) } })

  call dein#add('907th/vim-auto-save')

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
endif

" Load matchit to bounce between do and end in Ruby and between opening
" and closing tags in HTML.
if !has('gui_running')
  set noshowmatch
  let loaded_matchparen = 1  " Prevents DoMatchParen plugin from loading.
endif

runtime! init.d/*.vim
