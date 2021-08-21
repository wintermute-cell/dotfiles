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
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdalisue/suda.vim'
call plug#end()



" Basics
      set nocompatible
      set number relativenumber
      set encoding=utf-8
      syntax on
      filetype plugin on

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
