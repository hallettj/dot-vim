let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['flow-language-server', '--stdio', '--try-flow-bin'],
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ }
