return {
  'ziontee113/syntax-tree-surfer',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    -- normal mode swapping
    {
      'vU',
      function() vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'; return 'g@l' end,
      silent = true, expr = true,
      desc = 'swap parent node with previous sibling',
    },
    {
      'vD',
      function() vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'; return 'g@l' end,
      silent = true, expr = true,
      desc = 'swap parent node with next sibling',
    },
    {
      'vu',
      function() vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'; return 'g@l' end,
      silent = true, expr = true,
      desc = 'swap current node with previous sibling',
    },
    {
      'vd',
      function() vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot_Dot'; return 'g@l' end,
      silent = true, expr = true,
      desc = 'swap current node with next sibling',
    },

    -- Visual selection from normal mode
    { 'vx', '<cmd>STSSelectMasterNode<cr>', silent = true, desc = 'select parent node' },
    { 'vn', '<cmd>STSSelectCurrentNode<cr>', silent = true, desc = 'select current node' },

    -- Select nodes in visual mode
    { 'J', '<cmd>STSSelectNextSiblingNode<cr>', mode = 'x', silent = true, desc = 'select next sibling node' },
    { 'K', '<cmd>STSSelectPrevSiblingNode<cr>', mode = 'x', silent = true, desc = 'select prev sibling node' },
    { 'H', '<cmd>STSSelectParentNode<cr>', mode = 'x', silent = true, desc = 'select parent node' },
    { 'L', '<cmd>STSSelectChildNode<cr>', mode = 'x', silent = true, desc = 'select child node' },

    -- Swapping nodes in visual mode
    { '<A-j>', '<cmd>STSSwapNextVisual<cr>', mode = 'x', silent = true, desc = 'swap node with next sibling' },
    { '<A-k>', '<cmd>STSSwapPrevVisual<cr>', mode = 'x', silent = true, desc = 'swap node with prev sibling' },

    -- Targeted jump with virtual text
    {
      'gfu',
      -- > In this example, the Lua language schema uses "function",
      --  when the Python language uses "function_definition"
      --  we include both, so this keymap will work on both languages
      function() require('syntax-tree-surfer').targeted_jump({ 'function', 'arrow_function', 'function_definition ' }) end,
      silent = true, desc = 'jump to a function'
    },
    {
      'gif',
      function() require('syntax-tree-surfer').targeted_jump({ 'if_statement' }) end,
      silent = true, desc = 'jump to an if statement'
    },
    {
      'gfo',
      function() require('syntax-tree-surfer').targeted_jump({ 'for_statement' }) end,
      silent = true, desc = 'jump to a for statement'
    },
    {
      'gj',
      function() require('syntax-tree-surfer').targeted_jump({
          'function', 'if_statement', 'else_clause', 'else_statement',
          'elseif_statement', 'for_statement', 'while_statement',
          'switch_statement'
        })
      end,
      silent = true, desc = 'jump to a variety of treesitter node types'
    },
    {
      '<A-n>',
      function() require('syntax-tree-surfer').filtered_jump('default', true) end,
      silent = true, desc = 'jump to the next node of the same type last jumped to'
    },
    {
      '<A-p>',
      function() require('syntax-tree-surfer').filtered_jump('default', false) end,
      silent = true, desc = 'jump to the previous node of the same type last jumped to'
    },
  },
  -- These are the default options:
  opts = {
    highlight_group = 'STS_highlight',
    disable_no_instance_found_report = false,
    default_desired_types = {
      'function', 'arrow_function', 'function_definition', 'if_statement',
      'else_clause', 'else_statement', 'elseif_statement', 'for_statement',
      'while_statement', 'switch_statement'
    },
    left_hand_side = 'fdsawervcxqtzb',
    right_hand_side = 'jkl;oiu.,mpy/n',
    icon_dictionary = {
      ['if_statement'] = '',
      ['else_clause'] = '',
      ['else_statement'] = '',
      ['elseif_statement'] = '',
      ['for_statement'] = 'ﭜ',
      ['while_statement'] = 'ﯩ',
      ['switch_statement'] = 'ﳟ',
      ['function'] = '',
      ['function_definition'] = '',
      ['variable_declaration'] = ''
    }
  },
}
