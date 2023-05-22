-- `s`/`S` command jumps to occurrence of a pair of characters
return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    local leap = require('leap')
    leap.add_default_mappings()

    -- I have , and : swapped so I match that configuration in leap
    leap.opts.special_keys.prev_target = { '<tab>', ':' }
  end,

}
