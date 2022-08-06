require('material').setup({
  contrast = {
    popup_menu = true,
  },
  contrast_filetypes = {
    'terminal',
    'toggleterm',
  },
  italics = {
    comments = true,
    functions = false,
    keywords = true,
    strings = false,
    variables = false,
  },
  lualine_style = 'default', -- values are "default" or "stealth"
})
