" Customize colors
call denite#custom#option('default', {
     \ 'highlight_matched_char': 'None',
     \ 'highlight_matched_range': 'None',
     \ 'smartcase': v:true,
     \ 'vertical_preview': v:true,
     \})

" configure command to recursively list files
call denite#custom#var('file/rec', 'command', ['fd', '--follow', '.'])
call denite#custom#var('file/rec', 'min_cache_files', 0)

" configure command to search for strings within files
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
		\ ['--vimgrep', '--no-heading', '--smart-case', '--follow', '--no-ignore'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" additional keybindings for denite buffer
call denite#custom#map('insert', '<C-X>', '<denite:do_action:split>')
call denite#custom#map('insert', '<C-V>', '<denite:do_action:vsplit>')
call denite#custom#map('insert', '<C-J>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-K>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>')

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
