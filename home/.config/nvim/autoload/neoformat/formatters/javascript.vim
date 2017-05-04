function! neoformat#formatters#javascript#enabled() abort
    return ['prettierstandard', 'prettier']
endfunction

function! neoformat#formatters#javascript#prettier() abort
    return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin'],
        \ 'stdin': 1,
        \ }
endfunction

function! neoformat#formatters#javascript#prettierstandard() abort
    return {
        \ 'exe': 'prettier-standard',
        \ 'args': ['--stdin'],
        \ 'stdin': 1,
        \ }
endfunction
