require('lsp-inlayhints').setup {}

if vim.fn.has('nvim-0.8') == 1 then
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspAttach_inlayhints', { clear = true }),
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      require('lsp-inlayhints').on_attach(bufnr, client)
    end,
  })
end
