local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.sql_formatter,
  },
}
