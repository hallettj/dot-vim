" Single location for all of my global keybindings

" Map <Leader> to , key
let mapleader = " "

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
nnoremap <C--> <C-w>_
nnoremap <Leader>- <C-w>_
nnoremap <Leader>= <C-w>=

" Retains selection in visual mode when indenting blocks
vnoremap < <gv
vnoremap > >gv

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

" junegunn/fzf {{{
  nnoremap <C-b> :Buffers<cr>
  nnoremap <C-p> :Files<cr>
" }}}

" Shougo/denite.vim {{{
  nnoremap <leader>f :Denite -default-action=switch buffer file_rec<cr>
  nnoremap <leader>F :Denite file_rec:~<cr>
  nnoremap <leader>r :Denite -no-empty grep<cr>
  xnoremap <leader>r ygv:Denite -no-empty grep:::<C-R>"<cr>
  nnoremap <leader>R :Denite register<cr>
  nnoremap <leader>h :Denite command_history<cr>

  " git integration
  " nnoremap <leader>gl :Denite gitlog<cr>
  " nnoremap <leader>gL :Denite gitlog:all<cr>
  " nnoremap <leader>gs :Denite gitstatus<cr>
"}}}

" tpope/vim-fugitive / neoclide/vim-easygit {{{
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap          <leader>ge :Gedit<space>
  " nnoremap <silent> <leader>gl :silent Glog<CR>:copen<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
"}}}

" quickfix and location list
nnoremap <silent> <leader>lc :lclose<cr>:cclose<cr>
nnoremap <silent> <leader>lo :lopen<cr>
nnoremap <silent> <leader>cc :cclose<cr>:lclose<cr>
nnoremap <silent> <leader>co :copen<cr>

" Shougo/deoplete {{{
  imap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  smap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
  snoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
"}}}

" Shougo/neosnippet {{{
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
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
  xmap <leader>s <plug>(scratch-selection-clear)
" }}}

" magic registers
"
" The command performed after one of these keybindings is invoked will read from
" a register with a computed value. For example, to insert the current date
" before the the cursor: <leader>"dP
nnoremap <leader>"d "=strftime('%F')<cr>

" put directory of the open file in the default register
nnoremap <leader>"p "=expand('%:p:h')<cr>

" mundo
nnoremap <leader>u :MundoToggle<cr>

" IDE features
nnoremap <leader><space> :Neoformat<cr>
nnoremap <F5> :call LanguageClient_contextMenu()<cr>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<cr>

augroup TypescriptKeybindings
  autocmd!
  autocmd FileType typescript nnoremap <buffer> <silent> gd :TSDef<cr>
  autocmd FileType typescript nnoremap <buffer> <silent> K :TSDoc<cr>
  autocmd FileType typescript nnoremap <buffer> <leader>tdp :TSDefPreview<cr>
  autocmd FileType typescript nnoremap <buffer> <c-]> :TSTypeDef<cr>
  autocmd FileType typescript nnoremap <buffer> <silent> <F2> :TSRename<cr>
augroup END

nnoremap <F4> :ActivateTerminalPane<CR>
inoremap <F4> <C-\><C-n>:ActivateTerminalPane<CR>
tnoremap <F4> <C-\><C-n>:ActivateTerminalPane<CR>
