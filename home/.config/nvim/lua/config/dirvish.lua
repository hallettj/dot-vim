vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('dirvish_user_config', { clear = true }),
  pattern = 'dirvish',
  callback = function(opts)
    pcall( -- pcall catches errors in case the mapping was already deleted
      vim.api.nvim_buf_del_keymap, opts.buf, 'n', '<c-p>'
    )
  end
})
