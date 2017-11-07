" configure command to recursively list files
call denite#custom#var('file_rec', 'command', ['fd', '--follow', '.'])
call denite#custom#var('file_rec', 'min_cache_files', 0)

" configure command to search for strings within files
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
		\ ['--vimgrep', '--no-heading', '--smart-case', '--follow', '--no-ignore'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" additional keybindings for denite buffer
call denite#custom#map('_', '<Esc>', '<denite:enter_mode:normal>')
call denite#custom#map('insert', '<C-x>', '<denite:do_action:split>')

call denite#custom#map(
      \ 'normal',
      \ '+',
      \ '<denite:do_action:add>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'D',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ '-',
      \ '<denite:do_action:reset>',
      \ 'noremap'
      \)
