"###########################################################
"
" #### ##    ## #### ########     ##     ## #### ##     ##
"  ##  ###   ##  ##     ##        ##     ##  ##  ###   ###
"  ##  ####  ##  ##     ##        ##     ##  ##  #### ####
"  ##  ## ## ##  ##     ##        ##     ##  ##  ## ### ##
"  ##  ##  ####  ##     ##         ##   ##   ##  ##     ##
"  ##  ##   ###  ##     ##    ###   ## ##    ##  ##     ##
" #### ##    ## ####    ##    ###    ###    #### ##     ##
"
"###########################################################

call plug#begin('~/.config/nvim/plugged')
" Interface
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'yggdroot/indentline'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Editing
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'

" Functionality
Plug 'lambdalisue/suda.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'pseewald/anyfold'
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-surround'

" Lsp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
"Plug 'tami5/lspsaga.nvim'

" Completion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'

" Telescope
Plug 'nvim-lua/plenary.nvim' " Telescope dependency
Plug 'nvim-lua/popup.nvim' " Telescope dependency
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" Specific language extensions
" Plug 'PotatoesMaster/i3-vim-syntax'
" Plug 'vim-python/python-syntax'
" Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-dadbod'
Plug 'lervag/vimtex'
" Plug 'evanleck/vim-svelte'
" Plug 'tmhedberg/SimpylFold'  " Python folding
call plug#end()

" Theme
    set termguicolors
    let g:indentLine_color_term = 240
    let g:indentLine_char_list = ['¦', '┆', '┊', ':', '.']
    colorscheme monotone
    " Fitting lsp-saga to the theme
    highlight link LspSagaFinderSelection Search
    highlight link LspFloatWinNormal Normal
    highlight link LspFloatWinBorder PmenuThumb
    highlight link LspSagaRenameBorder PmenuSbar
    highlight link LspSagaHoverBorder PmenuSbar
    highlight link LspSagaSignatureHelpBorder PmenuSbar
    highlight link LspSagaLspFinderBorder PmenuSbar
    highlight link LspSagaCodeActionBorder PmenuSbar
    highlight link LspSagaAutoPreview PmenuSbar
    highlight link LspSagaDefPreviewBorder PmenuSbar
    highlight link LspSagaRenamePromptPrefix Title

" Basics
    set nocompatible
    set number relativenumber
    set encoding=utf-8
    syntax on
    filetype plugin indent on
    set scrolloff=10
    let g:python_highlight_all = 1
    set encoding=UTF-8
    let mapleader = "\<Space>"
    set hidden " allows switching buffers without saving
    set conceallevel=0
    set foldlevel=20

    " disable ex-mode access
    map Q <Nop>
    map q: <Nop>

" LSP config
lua << EOF
local lsp_installer = require('nvim-lsp-installer')
local cmp = require('cmp')

-- On attach callback
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = { noremap=true, silent=true }

    -- DONE WITH LSP-SAGA
    -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    buf_set_keymap('n', '<leader>l=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- lsp-saga mappings
    -- buf_set_keymap("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", opts)
    -- buf_set_keymap("n", "<leader>lx", "<cmd>Lspsaga code_action<cr>", opts)
    -- buf_set_keymap("n", "<leader>lh",  "<cmd>Lspsaga hover_doc<cr>", opts)
    -- buf_set_keymap("n", "<leader>lf",  "<cmd>Lspsaga lsp_finder<cr>", opts)
    -- buf_set_keymap("n", "<leader>ld",  "<cmd>Lspsaga lsp_finder<cr>", opts)
end

-- Basic cmp setup (sources, bindings, ...)
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
        }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' }, -- For ultisnips users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
    local opts = {}
    opts.on_attach = on_attach
    opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    server:setup(opts)
end)
EOF

" Telescope config
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_sorter      = require('telescope.sorters').get_fzy_sorter,
        promt_prefix     = ' >',

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
            }
        }
    }
require('telescope').load_extension('fzy_native')
EOF

" telescope config
    nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
    nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
    nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Treesitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = true,
      disable = { "python" },
  },
}
EOF

" enable anyfold
    autocmd FileType * AnyFoldActivate

" vim-tmux-navigator bindings
    nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" Nerdtree config (autostart, autokill, etc..)
    " autocmd VimEnter * :NERDTree | wincmd p

    " kill window if only nerdtree left
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    noremap <F3> :NERDTreeToggle<CR>
    autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" airline config
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='minimalist'
    let g:airline#extensions#tabline#formatter = 'unique_tail'

" pear-tree
    let g:pear_tree_repeatable_expand = 0
    let g:pear_tree_map_special_keys = 0
    let g:pear_tree_smart_openers = 1
    let g:pear_tree_smart_closers = 1
    let g:pear_tree_smart_backspace = 1

" suda config
    let g:suda_smart_edit = 1


" Completion
    set completeopt=menuone,noinsert
    set completeopt-=noselect

    let g:UltiSnipsExpandTrigger="<Tab>"
    let g:UltiSnipsJumpForwardTrigger="<C-j>"
    let g:UltiSnipsJumpBackwardTrigger="<C-b>"

    " Keybindings (also includes pear-tree keymaps for compatibility)
    imap <silent><expr> <Esc>   pumvisible() ? "\<C-e><Plug>(PearTreeFinishExpansion)" : "\<Plug>(PearTreeFinishExpansion)"
    imap <silent><expr> <BS>    pumvisible() ? "\<C-e><Plug>(PearTreeBackspace)"  : "\<Plug>(PearTreeBackspace)"
    imap <silent><expr> <CR>    pumvisible() ? "\<C-e><Plug>(PearTreeExpand)" : "\<Plug>(PearTreeExpand)"
    inoremap <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
    inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-y>" : "\<Tab>"

" Command autocomplete
    set wildmenu
    set wildmode=longest,list,full

" Disable autocomment on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Split to bottom and right
    set splitbelow splitright

" Remove trailing whitespaces on save
    autocmd BufWritePre * %s/\s\+$//e

" Tabbing and tabbed wrapping
    set breakindent
    set expandtab
    set shiftwidth=4
    set autoindent
    set smartindent

" Case insensitive search unless the search contains at least one capital letter
    set ignorecase
    set smartcase

" Hotkeys
    map <F7> :make<CR>
    nnoremap dv "_d

" Show warnings in floating window
    nnoremap <silent> g? <cmd>lua vim.diagnostic.open_float()<CR>

" Language specific settings
    " " Python
    " autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
    " autocmd BufRead *.py normal zx zR
    " Latex
    let g:vimtex_view_method = 'zathura'
    let g:tex_conceal = ''
    let g:vimtex_quickfix_enabled = 0
    let g:vimtex_quickfix_latexlog = {
                \ 'overfull' : 0,
                \ 'underfull' : 0,
                \ }
    " Markdown/Latex
    let g:indentLine_fileTypeExclude = ['tex', 'markdown']
    autocmd BufRead *.tex setlocal conceallevel=0
    autocmd BufRead *.md setlocal conceallevel=0

" Showing colors with hexokinase
    let g:Hexokinase_highlighters = ['virtual']

" Autorun prettier and eslint on save
    "autocmd BufWritePre *.js,*.ts,*.svelte,*.css !npx prettier --write ./%
    "autocmd BufWritePre *.js,*.ts,*.svelte,*.css !npx eslint ./%
