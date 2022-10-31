local null_ls = require('null-ls')
local h = require('null-ls.helpers')
local methods = require('null-ls.methods')

local FORMATTING = methods.internal.FORMATTING

-- Format Haskell files with ormolu. The haskell language server has built-in
-- formatting, but it doesn't let me control the ormolu version that is used.
local ormolu = {
  name = 'ormolu',
  method = FORMATTING,
  filetypes = { 'haskell' },
  generator = h.formatter_factory {
    command = 'ormolu',
    args = { '--cabal-default-extensions', '--stdin-input-file', '$FILENAME' },
    to_stdin = true,
  },
}

null_ls.setup {
  sources = {
    ormolu,
  },
}
