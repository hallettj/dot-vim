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
  use 'tpope/vim-fugitive' -- used by vim-rhubarb
  use 'tpope/vim-rhubarb' -- provides Github integration
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        keymaps = {
          noremap = true,

          -- I customized the default bindings to change ]c, [c to ]h [h
          ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
          ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

          ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
          ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
          ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        },
      }
    end
  }
  
  -- Visuals
  use 'overcache/NeoSolarized'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'machakann/vim-highlightedyank' -- highlight text after it has been yanked
  use 'psliwka/vim-smoothie'
  
  -- Tmux integration
  use 'christoomey/vim-tmux-navigator'
  use 'hallettj/tmux-config'
  use 'tpope/vim-tbone'
  
  use '907th/vim-auto-save'
  use 'liuchengxu/vim-which-key'
end)
