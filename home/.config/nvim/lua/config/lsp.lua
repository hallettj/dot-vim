local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp.preset('recommended')
lsp.set_preferences {
    set_lsp_keymaps = false,
}

-- We want to use the system version of hls. Lsp-zero automatically starts
-- language servers installed by Mason, but does not automatically start other
-- servers. This line gets configuration options from lsp-zero to provide when
-- explicitly starting hls.
local haskell_lsp = lsp.build_options('hls', {})

-- Configure rust_analyzer specially because we want to manage the server via
-- rust-tools. Calling `lsp.build_options` implicitly adds the given server to
-- an "exclude" list so that it is not started when calling `lsp.setup()`. But
-- the options table returned is populated with helpful settings provided by
-- lsp-zero.
local rust_lsp = lsp.build_options('rust_analyzer', {})

-- Configuration to make lsp-inlayhints.nvim work with TypeScript
local tsserver_config = {
    inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
    }
}
lsp.configure('tsserver', {
    settings = {
        typescript = tsserver_config,
        javascript = tsserver_config,
    },
})

-- Sets all of the LSP servers running.
lsp.setup()

-- Overide lsp-zero's virtual_text setting.
vim.diagnostic.config {
    virtual_text = true,
}

-- Language servers that are excluded from automatic startup by calling
-- `build_options` need to be started explicitly.

lspconfig.hls.setup(haskell_lsp)

-- rust-tools - get CodeLLDB from vscode extension for better debugging
local extension_path = vim.env.HOME ..
    '/.var/app/com.visualstudio.code/data/vscode/extensions/vadimcn.vscode-lldb-1.7.3/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
require('rust-tools').setup({
    server = rust_lsp,
    tools = {
        autoSetHints = false, -- We're getting hints from lsp-inlayhints instead
    },
    dap = {
        -- TODO: Ideally we would get dap adapter configuration from the
        -- `get_codelldb_adapter` function. But there seems to be some issue
        -- with nvim-dap that is preventing automatic port selection from
        -- working. The uncommented adapter config below is the same as we would
        -- get from `get_codelldb_adapter`, but does not use a random port.
        -- adapter = require('rust-tools.dap').get_codelldb_adapter(
        --     codelldb_path, liblldb_path
        -- ),
        adapter = {
            type = 'server',
            port = '45473', -- TODO: should be "${port}" to get a random port but there seems to be a DAP issue
            -- port = "${port}",
            host = '127.0.0.1',
            executable = {
                command = codelldb_path,
                args = {
                    '--liblldb', liblldb_path,
                    '--port', '45473', -- TODO: should be "${port}" but there seems to be a DAP issue
                    -- "--port", "${port}",
                },
            }
        },
    },
})
