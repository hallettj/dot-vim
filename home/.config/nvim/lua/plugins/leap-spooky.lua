-- operate on remote pieces of text using leap motions; e.g.
-- yar<textobject><leap>
return {
  'ggandor/leap-spooky.nvim',
  dependencies = {
    'ggandor/leap.nvim',
    'tpope/vim-repeat'
  },
  config = true,
}
