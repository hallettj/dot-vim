-- `ds`, `cs`, `ys`, and `S` commands manage delimiters
return {
  'machakann/vim-sandwich',
  init = function()

    -- use keybindings from vim-surround
    vim.cmd([[
  runtime macros/sandwich/keymap/surround.vim
]]   )

    local map = vim.keymap.set

    -- Text objects to select a text surrounded by brackets or user-specified characters.
    map('x', 'is', '<Plug>(textobj-sandwich-query-i)', { remap = true })
    map('x', 'as', '<Plug>(textobj-sandwich-query-a)', { remap = true })
    map('o', 'is', '<Plug>(textobj-sandwich-query-i)', { remap = true })
    map('o', 'as', '<Plug>(textobj-sandwich-query-a)', { remap = true })

    -- Text objects to select the nearest surrounded text automatically.
    map('x', 'iss', '<Plug>(textobj-sandwich-auto-i)', { remap = true })
    map('x', 'ass', '<Plug>(textobj-sandwich-auto-a)', { remap = true })
    map('o', 'iss', '<Plug>(textobj-sandwich-auto-i)', { remap = true })
    map('o', 'ass', '<Plug>(textobj-sandwich-auto-a)', { remap = true })

    -- Text objects to select a text surrounded by user-specified characters.
    map('x', 'im', '<Plug>(textobj-sandwich-literal-query-i)', { remap = true })
    map('x', 'am', '<Plug>(textobj-sandwich-literal-query-a)', { remap = true })
    map('o', 'im', '<Plug>(textobj-sandwich-literal-query-i)', { remap = true })
    map('o', 'am', '<Plug>(textobj-sandwich-literal-query-a)', { remap = true })

  end,
}
