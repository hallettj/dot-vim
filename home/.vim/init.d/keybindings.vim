" Single location for all of my global keybindings

" Map <Leader> to , key
let mapleader = " "
let maplocalleader = "  "

" Swap : and ,
nnoremap , :
vnoremap , :
nnoremap : ,
vnoremap : ,

" Swaps ' and `
nnoremap ' `
vnoremap ' `
nnoremap ` '
vnoremap ` '

" Fixes H and L movements for use with scrolloff
execute 'nnoremap H H'.&l:scrolloff.'k'
execute 'vnoremap H H'.&l:scrolloff.'k'
execute 'nnoremap L L'.&l:scrolloff.'j'
execute 'vnoremap L L'.&l:scrolloff.'j'

" Window management shortcuts
nnoremap <C-_> <C-w>_

" Retains selection in visual mode when indenting blocks
vnoremap < <gv
vnoremap > >gv

" Bounce between bracket pairs with the <tab> key.
nnoremap <tab> %
vnoremap <tab> %

" System copy/paste shortcuts
" These come from:
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Makes Vim's visual mode more consistent with tmux's
vnoremap <Enter> y

" gJ operates like J, except it takes a motion instead of a count
nnoremap gJ :set operatorfunc=JoinOperator<CR>g@
func! JoinOperator(submode)
  '[,']join
endfunc

" cd to directory of current file
nnoremap <Leader>cd :cd %:p:h<cr>

" tpop/vim-dispatch {{{
  nnoremap <leader>d :Dispatch<cr>
"}}}

" kien/ctrlp.vim {{{
  nnoremap <leader>f :CtrlP getcwd()<CR>
  nnoremap <leader>b :CtrlPBuffer<CR>
  "nnoremap <leader>T :CtrlPBufTag<CR>
  "nnoremap <leader>t :CtrlPTag<CR>
  nnoremap <leader>F :CtrlPRoot<CR>
  nnoremap <leader>r :CtrlPMRUFiles<CR>
  nnoremap <leader>M :CtrlPMixed<CR>
  nnoremap <leader>l :CtrlPLine<CR>
"}}}

" tpope/vim-fugitive {{{
  "nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap          <leader>ge :Gedit<space>
  "nnoremap <silent> <leader>gl :silent Glog<CR>:copen<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
"}}}

" airblaide/vim-gitgutter {{{
  nnoremap <leader>gh :GitGutterLineHighlightsToggle<cr>
  nnoremap <leader>gt :GitGutterToggle<cr>
  nnoremap <leader>gR :GitGutterAll<cr>
"}}}

" scrooloose/syntastic {{{
  nnoremap <silent> <Leader>e :SyntasticCheck<cr>:silent! Errors<cr>
  vnoremap <silent> <Leader>e :SyntasticCheck<cr>:silent! Errors<cr>
  " nnoremap <silent> <leader>lc :lclose<cr>:cclose<cr>
  " nnoremap <silent> <leader>lo :lopen<cr>
  nnoremap <silent> <leader>cc :cclose<cr>:lclose<cr>
  nnoremap <silent> <leader>co :copen<cr>
"}}}

" Shougo/deoplete {{{
  if has('nvim') && has('python3')
    " <Tab> completion (from
    " https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim):
    " " 1. If popup menu is visible, select and insert next item
    " " 2. Otherwise, if within a snippet, jump to next input
    " " 3. Otherwise, if preceding chars are whitespace, insert tab char
    " " 4. Otherwise, start manual autocomplete
    imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
          \ : (<SID>is_whitespace() ? "\<Tab>"
          \ : deoplete#mappings#manual_complete())

    smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
          \ : (<SID>is_whitespace() ? "\<Tab>"
          \ : deoplete#mappings#manual_complete())

    inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:is_whitespace()
      let col = col('.') - 1
      return !col || getline('.')[col - 1] =~? '\s'
    endfunction
  endif
"}}}

" rking/ag.vim {{{
  nnoremap <leader>ag :Ag<space>
  vnoremap <leader>ag "*y:Ag<space>'<C-R>*'<CR>
"}}}

" godlygeek/tabular {{{
  nnoremap <leader>a= :Tabularize / = /l0<cr>
  vnoremap <leader>a= :Tabularize / = /l0<cr>
  nnoremap <leader>a: :Tabularize /^[^:]*:\zs/l0l1<cr>
  vnoremap <leader>a: :Tabularize /^[^:]*:\zs/l0l1<cr>
" }}}

" mtth/scratch.vim {{{
  let g:scratch_no_mappings = 1
  nmap <leader>s <plug>(scratch-insert-reuse)
  nmap <leader>S <plug>(scratch-insert-clear)
  nnoremap <silent> <leader>ts :ScratchPreview<cr>
  xmap <leader>s <plug>(scratch-selection-reuse)
  xmap <leader>S <plug>(scratch-selection-clear)
" }}}
