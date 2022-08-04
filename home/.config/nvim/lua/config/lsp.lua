local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp.preset('recommended')
lsp.set_preferences {
    set_lsp_keymaps = false,
}

-- Configure hls specially because we want to use the system version instead of
-- managing the language server executable with Mason.
local haskell_lsp = lsp.build_options('hls', {})

-- Configure rust_analyzer specially because we want to manage the server via
-- rust-tools. Calling `lsp.build_options` implicitly adds the given server to
-- an "exclude" list so that it is not started when calling `lsp.setup()`. But
-- the options table returned is populated with helpful settings provided by
-- lsp-zero.
local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.setup()

-- Language servers that are configured specially need to be started explicitly.
lspconfig.hls.setup(haskell_lsp)
require('rust-tools').setup({ server = rust_lsp })
