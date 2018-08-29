let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['flow-language-server', '--stdio', '--try-flow-bin'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ }
