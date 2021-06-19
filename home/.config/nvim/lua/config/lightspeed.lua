require('lightspeed').setup {
  --grey_out_search_area = false,
}

local bind = vim.api.nvim_set_keymap

-- Make motion repeat bindings (; :) work like like they do with native jumps
function repeat_ft(reverse)
  local ls = require'lightspeed'
  ls.ft['instant-repeat?'] = true
  ls.ft:to(reverse, ls.ft['prev-t-like?'])
end
bind('n', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
bind('x', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
bind('n', ':', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})
bind('x', ':', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})
