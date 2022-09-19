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

    -- dependencies            |    required by
    use 'nvim-lua/popup.nvim'    -- Telescope
    use 'nvim-lua/plenary.nvim'  -- Telescope

    -- interface
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'ryanoasis/vim-devicons'
    use 'liuchengxu/vim-which-key'
    use 'folke/tokyonight.nvim'

    -- editing
    use 'tmsvg/pear-tree'       -- automatically pair parens, quotes, html-tags ..

    -- functionality
    use 'Konfekt/FastFold'
    use 'tpope/vim-surround'

    -- snippets
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    --use 'tami5/lspsaga.nvim'

    -- completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'quangnguyen30192/cmp-nvim-ultisnips'

    -- telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'

    -- telekasten
    use 'renerocksai/telekasten.nvim'

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'p00f/nvim-ts-rainbow' -- TODO: doesn't work in .md
    use 'nvim-treesitter/playground'

    -- markdown
    --use {
    --    'iamcco/markdown-preview.nvim',
    --    run = 'cd app && npm install',
    --    setup = function()
    --        vim.g.mkdp_filetypes = { "markdown" }
    --    end,
    --    ft = { "markdown" },
    --    disable = true,
    --}
    use 'junegunn/limelight.vim'
    use 'junegunn/goyo.vim'
    use {
        "nvim-neorg/neorg",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.norg.concealer"] = {},
                    ["core.norg.completion"] = {},
                    ["core.norg.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            }
                        }
                    }
                }
            }
        end,
        requires = "nvim-lua/plenary.nvim"
    }

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
vim.g.airline_theme = 'minimalist'
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = 'unique_tail'

--pear-tree
vim.g.pear_tree_repeatable_expand = 0
vim.g.pear_tree_map_special_keys = 0
vim.g.pear_tree_smart_openers = 1
vim.g.pear_tree_smart_closers = 1
vim.g.pear_tree_smart_backspace = 1

return p
