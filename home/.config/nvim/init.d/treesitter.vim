lua <<EOF
require 'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- "all", "maintained", or list of languages
  highlight = {
    enable = true,  -- false will disable the whole extension
    disable = {},   -- list of languages that will be disabled
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updateTime = 25,
    persist_queries = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        ["ie"] = "["..
          "((pair) @element)"..
          "((shorthand_property_identifier) @element)"..
          "(array (identifier) @element)"..
          "]",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["s.a"] = "@parameter.inner",
      },
      swap_previous = {
        ["s,a"] = "@parameter.inner",
      },
    },
  },
}
EOF
