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
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdalisue/suda.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'vim-python/python-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'yggdroot/indentline'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'chrisbra/unicode.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
call plug#end()

" Theme
      set termguicolors
      let g:indentLine_setColors = 0
      colorscheme monotone

" LSP config
lua << EOF
local lsp_installer = require("nvim-lsp-installer")
local coq = require("coq")

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
EOF

" Nerdtree config (autostart, autokill, etc..)
      autocmd VimEnter * :NERDTree | wincmd p
      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      noremap <F3> :NERDTreeToggle<CR>
      autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Autocompletion
      autocmd VimEnter * :COQnow --shut-up
      let g:coq_settings = { 'auto_start': 'shut-up' }
      set completeopt=menuone,noinsert
      set completeopt-=noselect

      let g:coq_settings = { "keymap.recommended": v:false, "keymap.pre_select": v:true }

      " Keybindings
      inoremap <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
      inoremap <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
      inoremap <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
      inoremap <silent><expr> <CR>    pumvisible() ? "\<C-e><CR>" : "\<CR>"
      inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-y>" : "\<Tab>"

" Command autocomplete
      set wildmenu
      set wildmode=longest,list,full

" pear-tree
      let g:pear_tree_repeatable_expand = 0

" Basics
      set nocompatible
      set number relativenumber
      set encoding=utf-8
      syntax on
      filetype plugin indent on
      set scrolloff=10
      let g:python_highlight_all = 1
      set encoding=UTF-8

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

" Folding
      nnoremap <Space> za

" Language specific settings
      " Python
      autocmd FileType python setlocal foldmethod=indent foldnestmax=2 foldlevel=20
      " JS
      autocmd FileType javascript setlocal foldmethod=indent foldnestmax=2 foldlevel=20 shiftwidth=4


" Showing colors with hexokinase
      let g:Hexokinase_highlighters = ['virtual']

" Autorun prettier on save
      autocmd BufWritePre *.js,*.ts,*.svelte Neoformat prettier
      autocmd BufWritePre *.js,*.ts,*.svelte <buffer> <cmd>EslintFixAll<CR>
