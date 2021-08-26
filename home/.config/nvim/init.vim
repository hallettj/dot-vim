" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" set vim home directory as vimrc is sourced
let $VIMFILES=fnamemodify(globpath(&rtp, 'bundle'), ":h")

set shell=/bin/bash

" Install plugins by requiring ~/.config/nivm/lua/plugins.lua
lua require('plugins')
augroup CompilePluginLazyLoaders
  autocmd!
  autocmd BufWritePost plugins.lua PackerCompile
augroup END

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

" Load configuration modules from ~/.config/nvim/lua/config/*.lua
lua require('config')

" Load vim configuration modules from ~/.config/nvim/init.d/*
runtime! init.d/*.vim
