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
Plug 'junegunn/goyo.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'yggdroot/indentline'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'chrisbra/unicode.vim'

" Editing
Plug 'terryma/vim-multiple-cursors'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'

" Functionality
Plug 'lambdalisue/suda.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'editorconfig/editorconfig-vim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Specific language extensions
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-python/python-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-dadbod'
Plug 'lervag/vimtex'
call plug#end()

" Theme
      set termguicolors
      let g:indentLine_setColors = 0
      colorscheme monotone

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
      " allows switching buffers without saving
      set hidden

" LSP config
lua << EOF
local lsp_installer = require("nvim-lsp-installer")
local coq = require("coq")
local nvim_lsp = require('lspconfig')

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
      local opts = {}
      if server.name == "eslint" then
            opts.on_attach = function (client, bufnr)
            client.resolved_capabilities.document_formatting = true
      end
      opts.settings = {
            format = { enable = true }, -- this will enable formatting
            }
      end
      server:setup(coq.lsp_ensure_capabilities(opts))
end)

local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      local opts = { noremap=true, silent=true }

      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
      buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
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
      nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
      nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
      nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
      nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Nerdtree config (autostart, autokill, etc..)
      autocmd VimEnter * :NERDTree | wincmd p

      " kill window if only nerdtree left
      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

      " kill tab if only nerdtree left
      autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

      noremap <F3> :NERDTreeToggle<CR>
      autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Airline config
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_theme='minimalist'
      let g:airline#extensions#tabline#formatter = 'unique_tail'

" pear-tree
      let g:pear_tree_repeatable_expand = 0
      let g:pear_tree_map_special_keys = 0
      let g:pear_tree_smart_openers = 1
      let g:pear_tree_smart_closers = 1
      let g:pear_tree_smart_backspace = 1

" Autocompletion
      autocmd VimEnter * :COQnow --shut-up
      let g:coq_settings = { 'auto_start': 'shut-up' }
      set completeopt=menuone,noinsert
      set completeopt-=noselect

      let g:coq_settings = { "keymap.recommended": v:false, "keymap.pre_select": v:true }

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
      set shiftwidth=6
      set autoindent
      set smartindent

" Case insensitive search unless the search contains at least one capital letter
      set ignorecase
      set smartcase

" Hotkeys
      map <F7> :make<CR>
      nnoremap dv "_d

" Show warnings in floating window
      nnoremap <silent> g? <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" Language specific settings
      " Python
      autocmd FileType python setlocal foldmethod=indent foldnestmax=2 foldlevel=20
      " JS
      autocmd FileType javascript setlocal foldmethod=indent foldnestmax=2 foldlevel=20 shiftwidth=4
      " Latex
      let g:vimtex_view_method = 'zathura'



" Showing colors with hexokinase
      let g:Hexokinase_highlighters = ['virtual']

" Autorun prettier and eslint on save
      autocmd BufWritePre *.js,*.ts,*.svelte,*.css !npx prettier --write ./%
      autocmd BufWritePre *.js,*.ts,*.svelte,*.css !npx eslint ./%
