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
  " nnoremap <leader>d :Dispatch<cr>
"}}}

" junegunn/fzf {{{
  nnoremap <C-b> :Buffers<cr>
  nnoremap <C-p> :Files<cr>
" }}}

" Shougo/denite.vim {{{
  nnoremap <leader>f :Denite -default-action=switch buffer file/rec<cr>
  nnoremap <leader>F :Denite file/rec:~<cr>
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
  nnoremap <silent> <leader>gs :vert Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap          <leader>ge :Gedit<space>
  " nnoremap <silent> <leader>gl :silent Glog<CR>:copen<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gR :Gremove<CR>
"}}}

" quickfix and location list
nnoremap <silent> <leader>lc :lclose<cr>:cclose<cr>
nnoremap <silent> <leader>lo :lopen<cr>
nnoremap <silent> <leader>cc :cclose<cr>:lclose<cr>
nnoremap <silent> <leader>co :copen<cr>

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
nmap <leader><space> <plug>(coc-format)

nnoremap <F4> :ActivateTerminalPane<CR>
inoremap <F4> <C-\><C-n>:ActivateTerminalPane<CR>
tnoremap <F4> <C-\><C-n>:ActivateTerminalPane<CR>

" coc

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Pressing enter closes popupmenu if it is open, and inserts a line break.
" Defer to pear-tree when the popupmenu is not visible.
imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Plug>(PearTreeExpand)"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

nmap <leader>cl <Plug>(coc-codelens-action)
nmap <leader>q <plug>(coc-fix-current)
nnoremap <leader>ef :CocCommand eslint.executeAutofix<cr>
nmap <leader>ev <plug>(coc-diagnostic-info)

" Shortcuts for denite interface
" Show extension list
nnoremap <silent> <space>de  :<C-u>Denite coc-extension<cr>
" Show symbols of current buffer
nnoremap <silent> <space>do  :<C-u>Denite coc-symbols<cr>
" Search symbols of current workspace
nnoremap <silent> <space>dt  :<C-u>Denite coc-workspace<cr>
" Show diagnostics of current workspace
nnoremap <silent> <space>da  :<C-u>Denite coc-diagnostic<cr>
" Show available commands
nnoremap <silent> <space>dc  :<C-u>Denite coc-command<cr>
" Show available services
nnoremap <silent> <space>ds  :<C-u>Denite coc-service<cr>
" Show links of current buffer
nnoremap <silent> <space>dl  :<C-u>Denite coc-link<cr>
