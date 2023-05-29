return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'all', -- "all", "maintained", or list of languages
        highlight = {
          enable = true,          -- false will disable the whole extension
          disable = {},           -- list of languages that will be disabled
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = { enable = true },
      }
    end,
  },
  {
    'RRethy/nvim-treesitter-textsubjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textsubjects = {
          enable = true,
          prev_selection = ',',
          keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
          },
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          move = {
            enable = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          select = {
            enable = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = false },
        },
      }
    end,
  },
  {
    'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        playground = {
          enable = true,
          disable = {},
          updateTime = 25,
          persist_queries = false,
        },
      }
    end,
  },
  -- Shows lines with containing function, struct, etc. if that would otherwise
  -- be scrolled off the top of the screen.
  { 'nvim-treesitter/nvim-treesitter-context', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
}
