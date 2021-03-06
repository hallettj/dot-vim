" Single location for all of my global keybindings

" Map <Leader> to , key
let mapleader = " "

nnoremap <silent> <leader> :WhichKey '<space>'<cr>
call which_key#register('<space>', "g:which_key_map")
let g:which_key_map = {}

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
let g:which_key_map['-'] = ['<C-w>_', 'maximize window vertically']
let g:which_key_map['='] = ['<C-w>=', 'set windows to equal sizes']

" Retains selection in visual mode when indenting blocks
vnoremap < <gv
vnoremap > >gv

" System copy/paste shortcuts
" These come from:
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <Leader>y "+y
let g:which_key_map.y = 'yank to system clipboard'
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
let g:which_key_map.p = 'put after cursor from system clipboard'
let g:which_key_map.P = 'put before cursor from system clipboard'

" Makes Vim's visual mode more consistent with tmux's
vnoremap <Enter> y

" gJ operates like J, except it takes a motion instead of a count
nnoremap gJ :set operatorfunc=JoinOperator<CR>g@
func! JoinOperator(submode)
  '[,']join
endfunc

" navigation
nnoremap <silent> <C-p> :<C-u>CocList files<cr>
nnoremap <silent> <leader>b :<C-u>CocList buffers<cr>
let g:which_key_map.b = 'list buffers'
nnoremap <silent> <leader>h :<C-u>CocList cmdhistory<cr>
let g:which_key_map.h = 'list command history'

nnoremap <silent> <leader>de :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>do :<C-u>CocList outline<cr>
nnoremap <silent> <leader>da :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>dc :<C-u>CocList commands<cr>
nnoremap <silent> <leader>ds :<C-u>CocList services<cr>
let g:which_key_map.d = {
  \ 'name' : '+list',
  \ 'b' : 'buffers',
  \ 'h' : 'command history',
  \ 'e' : 'coc extensions',
  \ 'o' : 'document outline',
  \ 'a' : 'project diagnostics',
  \ 'c' : 'coc commands',
  \ 's' : 'coc services',
  \ }

" IDE features
nmap <leader>ca <Plug>(coc-codeaction-selected)
vmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>cc <Plug>(coc-codeaction-line)
nmap <leader>cf <Plug>(coc-codeaction)
nmap <leader>cF <Plug>(coc-format-selected)
vmap <leader>cF <Plug>(coc-format-selected)
nmap <leader>cg <Plug>(coc-openlink)
nmap <leader>cl <Plug>(coc-codelens-action)
nmap <leader>cq <Plug>(coc-fix-current)
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>cR <Plug>(coc-refactor)
let g:which_key_map.c = {
  \ 'name' : '+IDE',
  \ 'a' : 'code actions for selection / motion',
  \ 'c' : 'code actions for current line',
  \ 'f' : 'code actions for entire file',
  \ 'F' : 'format selected',
  \ 'g' : 'open link under cursor',
  \ 'l' : 'codeLens command of current line',
  \ 'q' : 'quickfix current line',
  \ 'r' : 'rename',
  \ 'R' : 'refactor',
  \ }

" tpope/vim-fugitive / neoclide/vim-easygit {{{
  nnoremap <silent> <leader>gs :vert Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap          <leader>ge :Gedit<space>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gR :Gremove<CR>
"}}}
let g:which_key_map.g = {
  \ 'name' : '+git',
  \ 's' : 'git status in vert split',
  \ 'd' : 'git diff',
  \ 'c' : 'git commit',
  \ 'b' : 'git blame',
  \ 'e' : 'edit a fugitive object',
  \ 'p' : 'git push',
  \ 'w' : 'write file and stage',
  \ 'R' : 'git rm',
  \ }

" magic registers
"
" The command performed after one of these keybindings is invoked will read from
" a register with a computed value. For example, to insert the current date
" before the the cursor: <leader>"dP
nnoremap <leader>"d "=strftime('%F')<cr>
nnoremap <leader>"p "=expand('%:p:h')<cr>
let g:which_key_map['"'] = {
  \ 'name' : '+magic_register',
  \ 'd' : 'put current date in unnamed register',
  \ 'p' : 'put directory of open file in unnamed register',
  \ }

" mundo
nnoremap <leader>u :MundoToggle<cr>

" IDE features
nmap <leader><space> <plug>(coc-format)

nnoremap <F4> :ActivateTerminalPane<CR>
inoremap <F4> <C-\><C-n>:ActivateTerminalPane<CR>
tnoremap <F4> <C-\><C-n>:ActivateTerminalPane<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> [C <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]C <Plug>(coc-diagnostic-next-error)

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit at current position
nmap gC <Plug>(coc-git-commit)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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
" Defer to vim-smartinput when the popupmenu is not visible.
"
" It seems that coc.nvim incorrectly puts the popupmenu into state 2 (as
" described in the popupmenu-completion documentation) when it should be in
" state 3. In state 2 <Enter> inserts the currently selected match instead of
" inserting a line break.
call smartinput#map_to_trigger('i', '<Plug>SmartinputCR', '<Enter>', '<CR>')
imap <expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<Plug>SmartinputCR"
