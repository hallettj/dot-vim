let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set termguicolors

if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Fira Code 9')
endif
