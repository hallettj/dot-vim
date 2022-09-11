vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha

require('catppuccin').setup({
  transparent_background = false,
  term_colors = false,
  compile = {
    enabled = true,
    path = vim.fn.stdpath('cache') .. '/catppuccin',
  },
  dim_inactive = {
    enabled = false,
    shade = 'dark',
    percentage = 0.15,
  },
  styles = {
    comments = { 'italic' },
    conditionals = { 'italic' },
    loops = {},
    functions = {},
    keywords = { 'italic' },
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
    cmp = true,
    dap = {
      enabled = true,
    },
    fidget = true,
    gitsigns = true,
    lightspeed = true,
    lsp_trouble = true,
    telescope = true,
    treesitter = true,
    which_key = true,
  },
  highlight_overrides = {
    all = {
      -- disable italic for parameters
      TSParameter = { style = {} },
      TSNamespace = { style = {} },
      -- italic for `for` in `impl X for Y` in Rust
      TSRepeat = { style = { 'italic' } },
      -- italic for `self` in Rust
      TSVariableBuiltin = { style = { 'italic' } },
    },
  },
})
