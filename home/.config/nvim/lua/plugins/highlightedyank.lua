-- highlight text after it has been yanked
return {
  'machakann/vim-highlightedyank',
  init = function()
    vim.g.highlightedyank_highlight_duration = 400
    vim.api.nvim_set_option('inccommand', 'nosplit')
  end,
}
