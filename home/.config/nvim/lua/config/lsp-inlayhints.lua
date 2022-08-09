local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require('lsp-inlayhints').setup {}

if vim.fn.has('nvim-0.8') == 1 then
  local lsp_augroup = augroup('LSP_preferences', { clear = true })
  autocmd('LspAttach', {
    group = lsp_augroup,
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- Start lsp-inlayhints to display virtual text hints for function return
      -- types, parameter names, etc.
      require('lsp-inlayhints').on_attach(bufnr, client)

      -- Show code lenses including, for example, imported symbols for blanket
      -- import lines in Haskell modules. This also enables code lens actions.
      -- Code lenses don't show up unless the `refresh` function is called.
      if client.server_capabilities.codeLensProvider then
        autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
          group = lsp_augroup,
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
      end
    end,
  })
end
