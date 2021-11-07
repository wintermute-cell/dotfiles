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
Plug 'vim-scripts/AutoComplPop'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-python/python-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'yggdroot/indentline'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'vimwiki/vimwiki'
Plug 'chrisbra/unicode.vim'
call plug#end()

" LSP config
lua << EOF
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
EOF

" Nerdtree config (autostart, autokill, etc..)
      autocmd VimEnter * :NERDTree | wincmd p
      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      noremap <F3> :NERDTreeToggle<CR>
      autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Use tab to confirm autocompletion.
      inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Autocomplete menu configuration
      set completeopt-=menu
      set completeopt+=menuone
      set completeopt-=longest
      set completeopt-=preview
      set completeopt+=noinsert
      set completeopt-=noselect

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
      nnoremap dv "_dd

" Theme
      set termguicolors
      let g:indentLine_setColors = 0
      colorscheme monotone

" Show warnings in floating window
      nnoremap <silent> g? <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" Folding
      nnoremap <Space> za

" Language specific settings
      " Python
      autocmd FileType python setlocal foldmethod=indent foldnestmax=2 foldlevel=20
      " JS
      autocmd FileType javascript setlocal foldmethod=indent foldnestmax=2 foldlevel=20 shiftwidth=2


" Showing colors with hexokinase
      let g:Hexokinase_highlighters = ['virtual']
