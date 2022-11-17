-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Bootstrap packer if it is not installed.
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Packer needs to compile lazy loading hooks after plugin configuration changes. Do this
-- automatically on changes to this file. This also sources changes so that
-- calls to `:PackerInstall` or `:PackerUpdate` use the latest config.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('packer_user_config', { clear = true }),
    pattern = 'plugins.lua',
    callback = function()
        vim.cmd.source '<afile>'
        vim.cmd.PackerCompile()
    end,
})

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-sensible'
    use 'tpope/vim-sleuth'

    -- Automatically load environment variables set in a `.envrc` or `.env` file
    -- when changing to a directory with such a file.
    use 'direnv/direnv.vim'

    -- Navigation
    use 'justinmk/vim-dirvish' -- file browser to replace netrw
    use 'kristijanhusak/vim-dirvish-git'
    use { 'simnalamburt/vim-mundo', cmd = 'MundoToggle' } -- UI for navigating undo history
    use { 'sindrets/winshift.nvim', config = function() require('config/winshift') end }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'folke/trouble.nvim' },
            { 'kyazdani42/nvim-web-devicons', opt = true },
        },
        config = function() require('config/telescope') end,
    }
    -- Show input prompts in floating window; make selections with Telescope
    use { 'stevearc/dressing.nvim', config = function() require('config/dressing') end }
    use {
        'folke/trouble.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require('config/trouble') end,
    }
    use { 'lotabout/skim', run = './install' } -- Install skim for zsh integration
    use {
        'simrat39/symbols-outline.nvim',
        config = function() require('config/symbols-outline') end,
    }

    use 'tpope/vim-unimpaired' -- shortcuts for cycling/toggling different things
    use 'tpope/vim-characterize' -- show information about character under cursor
    use 'tpope/vim-commentary' -- manipulate code comments
    use 'tpope/vim-eunuch' -- commands for manipulating files and directories
    use 'tpope/vim-repeat' -- makes the `.` command work with third-party actions
    use 'tpope/vim-rsi' -- add Emacs-like shortcuts to command mode
    use 'AndrewRadev/splitjoin.vim' -- `gS` and `gJ` commands split or join lines

    -- Movements
    use 'machakann/vim-sandwich' -- `ds`, `cs`, `ys`, and `S` commands manage delimiters
    use {
        -- `s`/`S` command jumps to occurrence of a pair of characters
        'ggandor/leap.nvim',
        config = function() require('config/leap') end
    }
    use {
        -- operate on remote pieces of text using leap motions; e.g.
        -- yar<textobject><leap>
        'ggandor/leap-spooky.nvim',
        requires = { 'ggandor/leap.nvim' },
        config = function () require('config/leap-spooky') end,
    }
    use 'wellle/targets.vim' -- more options for movements like `i` and `a`

    -- Text objects
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'kana/vim-textobj-user' -- dependency for third-party text objects
    use 'kana/vim-textobj-entire' -- `ae`: entire buffer, `ie`: excludes empty lines
    use 'kana/vim-textobj-line' -- `al`: entire line, `il` excludes whitespace

    -- more from kana
    use 'kana/vim-niceblock' -- makes `I` and `A` work in line-wise visual mode

    -- IDE features
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip', config = function() require('config/luasnip') end, },
            { 'rafamadriz/friendly-snippets' },

            -- Support for specific languages
            {
                'simrat39/rust-tools.nvim',
                branch = 'modularize_and_inlay_rewrite', -- CodeLLDB v1.7 requires modularize_and_inlay_rewrite branch
                requires = {
                    { 'neovim/nvim-lspconfig' },
                    { 'nvim-lua/plenary.nvim' },
                    { 'mfussenegger/nvim-dap' },
                },
            },
        },
        config = function() require('config/lsp') end
    }
    use { 'j-hui/fidget.nvim', config = function() require('config/fidget') end } -- show progress messages from language servers
    use {
        'lvimuser/lsp-inlayhints.nvim',
        event = vim.fn.has('nvim-0.8') == 1 and 'LspAttach' or nil,
        config = function() require('config/lsp-inlayhints') end,
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('config/null-ls') end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('config/treesitter') end
    }
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/playground'
    use {
        'ziontee113/syntax-tree-surfer',
        config = function() require('config/tree-surfer') end
    }
    use {
        'akinsho/toggleterm.nvim',
        config = function() require('config/toggleterm') end
    }

    -- Debugging
    use { 'mfussenegger/nvim-dap' }

    -- Language support
    use { 'DeltaWhy/vim-mcfunction', ft = 'mcfunction' }
    use { 'vmchale/dhall-vim', ft = 'dhall' }
    use {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'hrsh7th/nvim-cmp', opt = true },
        },
        config = function() require('config/rust-crates') end,
    }

    -- Writing assistance
    use 'kana/vim-smartinput' -- automatically closes delimiters as they are typed

    -- git integration
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'
    use {
        'sindrets/diffview.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require('config/diffview') end
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('config/gitsigns') end
    }
    use {
        'ldelossa/gh.nvim',
        requires = {
            { 'ldelossa/litee.nvim' },
            { 'nvim-telescope/telescope.nvim', opt = true }
        },
        config = function() require('config/gh') end
    }

    -- Visuals
    use 'kyazdani42/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require('config/lualine') end
    }
    use 'machakann/vim-highlightedyank' -- highlight text after it has been yanked

    -- Color Schemes
    use {
        'catppuccin/nvim', as = 'catppuccin',
        config = function() require('config/colorscheme-catppuccin') end,
        run = function() require('catppuccin').compile() end,
    }
    use {
        'marko-cerovac/material.nvim',
        after = { 'lualine.nvim' },
        config = function() require('config/colorscheme-material') end
    }
    use {
        'ishan9299/nvim-solarized-lua',
        config = function() require('config/solarized') end
    }
    use {
        'folke/tokyonight.nvim',
        config = function() require('config/colorscheme-tokyonight') end,
    }
    use {
        'mcchrish/zenbones.nvim',
        requires = 'rktjmp/lush.nvim',
        config = function() require('config/colorscheme-zenbones') end
    }

    -- Tmux integration
    use 'christoomey/vim-tmux-navigator'
    use 'hallettj/tmux-config'
    use 'tpope/vim-tbone'

    use '907th/vim-auto-save'
    use {
        'folke/which-key.nvim',
        config = function() require('config/which-key') end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
