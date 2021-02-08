" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" set vim home directory as vimrc is sourced
let $VIMFILES=fnamemodify(globpath(&rtp, 'bundle'), ":h")

if has('vim_starting')
  set nocompatible          " We're running Vim, not Vi!
endif

set shell=/bin/bash

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-sensible'

" Navigation
Plug 'justinmk/vim-dirvish' " file browser to replace netrw
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'airblade/vim-rooter' " set working directory based on `.git/`
Plug 'simnalamburt/vim-mundo' " UI for navigating undo history
Plug 'andymass/vim-tradewinds'

Plug 'tpope/vim-unimpaired' " shortcuts for cycling/toggling different things
Plug 'tpope/vim-characterize' " show information about character under cursor
Plug 'tpope/vim-commentary' " manipulate code comments
Plug 'tpope/vim-eunuch' " commands for manipulating files and directories
Plug 'tpope/vim-repeat' " makes the `.` command work with third-party actions
Plug 'tpope/vim-rsi' " add Emacs-like shortcuts to command mode
Plug 'AndrewRadev/splitjoin.vim' " `gS` and `gJ` commands split or join lines

" Movements
Plug 'machakann/vim-sandwich' " `ds`, `cs`, `ys`, and `S` commands manage delimiters
Plug 'justinmk/vim-sneak' " `s` command jumps to occurrence of a pair of characters
Plug 'wellle/targets.vim' " more options for movements like `i` and `a`

" Language support
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/jsonc.vim'
Plug 'vmchale/just-vim'
Plug 'jparise/vim-graphql'
Plug 'DeltaWhy/vim-mcfunction'

" Text objects
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'kana/vim-textobj-user' " dependency for third-party text objects
Plug 'kana/vim-textobj-entire' " `ae`: entire buffer, `ie`: excludes empty lines
Plug 'kana/vim-textobj-line' " `al`: entire line, `il` excludes whitespace

" more from kana
Plug 'kana/vim-niceblock' " makes `I` and `A` work in line-wise visual mode

" IDE features
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/playground'

" Writing assistance
Plug 'kana/vim-smartinput' " automatically closes delimiters as they are typed

" git integration
Plug 'tpope/vim-fugitive' " used by vim-rhubarb
Plug 'tpope/vim-rhubarb' " provides Github integration

" Visuals
Plug 'iCyMind/NeoSolarized'
Plug 'drmikehenry/vim-fontdetect'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if has('nvim')
  Plug 'machakann/vim-highlightedyank' " highlight text after it has been yanked
endif
Plug 'psliwka/vim-smoothie'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'hallettj/tmux-config'
Plug 'tpope/vim-tbone'

Plug '907th/vim-auto-save'

call plug#end()

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
