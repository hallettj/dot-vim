-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Bootstrap the packer plugin manager
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-sensible'

  -- Navigation
  use 'justinmk/vim-dirvish' -- file browser to replace netrw
  use 'kristijanhusak/vim-dirvish-git'
  use {'simnalamburt/vim-mundo', cmd = 'MundoToggle'} -- UI for navigating undo history
  use {'andymass/vim-tradewinds', keys = {'<C-w>gh', '<C-w>gl'}}
  use {'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} }}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {
    'fannheyward/telescope-coc.nvim',
    config = function()
      require('telescope').load_extension('coc')
    end
  }
  use {'lotabout/skim', run = './install'} -- Install skim for zsh integration

  use 'tpope/vim-unimpaired' -- shortcuts for cycling/toggling different things
  use 'tpope/vim-characterize' -- show information about character under cursor
  use 'tpope/vim-commentary' -- manipulate code comments
  use 'tpope/vim-eunuch' -- commands for manipulating files and directories
  use 'tpope/vim-repeat' -- makes the `.` command work with third-party actions
  use 'tpope/vim-rsi' -- add Emacs-like shortcuts to command mode
  use 'AndrewRadev/splitjoin.vim' -- `gS` and `gJ` commands split or join lines

  -- Movements
  use 'machakann/vim-sandwich' -- `ds`, `cs`, `ys`, and `S` commands manage delimiters
  use 'ggandor/lightspeed.nvim' -- `s`/`S` command jumps to occurrence of a pair of characters
  use 'wellle/targets.vim' -- more options for movements like `i` and `a`

  -- Language support
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'DeltaWhy/vim-mcfunction', ft = 'mcfunction'}
  use {'vmchale/dhall-vim', ft = 'dhall'}

  -- Text objects
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'kana/vim-textobj-user' -- dependency for third-party text objects
  use 'kana/vim-textobj-entire' -- `ae`: entire buffer, `ie`: excludes empty lines
  use 'kana/vim-textobj-line' -- `al`: entire line, `il` excludes whitespace

  -- more from kana
  use 'kana/vim-niceblock' -- makes `I` and `A` work in line-wise visual mode

  -- IDE features
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/playground'

  -- Writing assistance
  use 'kana/vim-smartinput' -- automatically closes delimiters as they are typed

  -- git integration
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'junegunn/gv.vim'
  use {'sindrets/diffview.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup {
        -- This is copied-and-pasted from the gitsigns readme using the old nvim
        -- 0.6-compatible neovim lua API. The readme has an equivalent example
        -- that uses a newer API that requires neovim 0.7.
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          -- Navigation
          map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
          map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

          -- Actions
          map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
          map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
          map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
          map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
          map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
          map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
          map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
          map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
          map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

          -- Text object
          map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      }
    end,
  }

  -- Visuals
  use 'ishan9299/nvim-solarized-lua'
  use {'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim'}
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
  use 'machakann/vim-highlightedyank' -- highlight text after it has been yanked

  -- Tmux integration
  use 'christoomey/vim-tmux-navigator'
  use 'hallettj/tmux-config'
  use 'tpope/vim-tbone'

  -- Lua support
  use 'jakelinnzy/autocmd-lua'

  use '907th/vim-auto-save'
  use 'liuchengxu/vim-which-key'
end)
