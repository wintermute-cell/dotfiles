local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print "plugins.lua: requiring packer failed!"
    return
end

-------------
-- PLUGINS -----
------------------------------
local p = packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- misc
    use 'ThePrimeagen/vim-be-good'

    -- dependencies            |    required by
    use 'nvim-lua/popup.nvim'    -- Telescope
    use 'nvim-lua/plenary.nvim'  -- Telescope

    -- interface
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'ryanoasis/vim-devicons'
    use 'folke/tokyonight.nvim'
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use { 'folke/which-key.nvim',
        config = function()
            require("which-key").setup { }
        end
    }
    use {'RRethy/vim-hexokinase',
        run = "make hexokinase"
    }
    use { 'anuvyklack/pretty-fold.nvim',
        config = function()
            require('pretty-fold').setup {
                fill_char = '·',
            }
        end
    }

    -- editing
    use 'windwp/nvim-autopairs'

    -- functionality
    use 'Konfekt/FastFold'
    use 'tpope/vim-surround'
    use 'lambdalisue/suda.vim'
    use 'mbbill/undotree'
    use 'moll/vim-bbye'
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- language tools
    use 'lervag/vimtex'
    use 'elkowar/yuck.vim'

    -- telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

----------------
-- PLUGIN CONFIG -----
------------------------------
-- airline
vim.g.airline_theme = 'base16_atelier_cave_light'
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = 'unique_tail'

--pear-tree
-- vim.g.pear_tree_repeatable_expand = 0
-- vim.g.pear_tree_map_special_keys = 0
-- vim.g.pear_tree_smart_openers = 1
-- vim.g.pear_tree_smart_closers = 1
-- vim.g.pear_tree_smart_backspace = 1

-- suda
vim.g.suda_smart_edit = 1

-- vimtex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_ignore_filters = { 'Overfull', 'Underfull', 'Warning' }
vim.g.vimtex_quickfix_open_on_warning = 0

-- hexokinase
vim.g["Hexokinase_highlighters"] = {'backgroundfull'}

return p
