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
call plug#end()

" Nerdtree autostart & autokill
      autocmd VimEnter * :NERDTree | wincmd p
      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      noremap <F3> :NERDTreeToggle<CR>

" Use tab to confirm autocompletion.
      inoremap <expr> <Tab> pumvisible() ? "\<Enter>" : "\<Tab>"

" pear-tree
      let g:pear_tree_repeatable_expand = 0

" Basics
      set nocompatible
      set number relativenumber
      set encoding=utf-8
      syntax on
      filetype plugin on
      set scrolloff=10

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
