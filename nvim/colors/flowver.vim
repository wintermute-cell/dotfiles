" Name:         Flowver for Vim
" License:      Vim License (see `:help license`)

if !(has('termguicolors') && &termguicolors) && !has('gui_running')
      \ && (!exists('&t_Co') || &t_Co < 16)
  echoerr '[Flowver for Vim] There are not enough colors.'
  finish
endif

set background=light

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'flowver'

hi Normal ctermfg=0 ctermbg=15 guifg=#222222 guibg=#fff6f6 guisp=NONE cterm=NONE gui=NONE
hi Cursor ctermfg=7 ctermbg=0 guifg=#ffeaea guibg=#222222 guisp=NONE cterm=NONE gui=NONE
hi Error ctermfg=0 ctermbg=9 guifg=#222222 guibg=#ffdddd guisp=NONE cterm=NONE gui=NONE
hi Constant ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Directory ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Function ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Identifier ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi PreProc ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Special ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Title ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Type ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE

" treesitter markdown headers
hi mdH1Prefix ctermfg=0 ctermbg=14 guifg=#222222 guibg=#009BAA guisp=NONE cterm=NONE gui=NONE
hi mdH1Text ctermfg=0 ctermbg=14 guifg=#222222 guibg=#009BAA guisp=NONE cterm=bold gui=bold
hi mdH2Prefix guifg=#ff79c6 guibg=NONE gui=bold
hi mdH2Text guifg=#ff79c6 guibg=NONE gui=nocombine
hi mdH3Prefix guifg=#ffb86c guibg=NONE gui=bold
hi mdH3Text guifg=#ffb86c guibg=NONE gui=nocombine
hi mdH4Prefix guifg=#8be9fd guibg=NONE gui=bold
hi mdH4Text guifg=#8be9fd guibg=NONE gui=nocombine
hi mdH5Prefix guifg=#f1fa8c guibg=NONE gui=bold
hi mdH5Text guifg=#f1fa8c guibg=NONE gui=nocombine

"hi markdownH1 ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH1Delimiter ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH2 ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH2Delimiter ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH3 ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH3Delimiter ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH4 ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH4Delimiter ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH5 ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH5Delimiter ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH6 ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownH6Delimiter ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
"hi markdownListMarker ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
"hi markdownOrderedListMarker ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Statement ctermfg=0 ctermbg=NONE guifg=#222222 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi Comment ctermfg=8 ctermbg=NONE guifg=#878781 guibg=NONE guisp=NONE cterm=NONE,italic gui=NONE,italic
hi CursorLine ctermfg=NONE ctermbg=7 guifg=NONE guibg=#ffeaea guisp=NONE cterm=NONE gui=NONE
hi CursorLineNr ctermfg=1 ctermbg=NONE guifg=#ad4f4f guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Folded ctermfg=0 ctermbg=7 guifg=#222222 guibg=#ffeaea guisp=NONE cterm=NONE,italic gui=NONE,italic
hi IncSearch ctermfg=0 ctermbg=14 guifg=#222222 guibg=#a1eeed guisp=NONE cterm=NONE gui=NONE
hi LineNr ctermfg=8 ctermbg=NONE guifg=#878781 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi MatchParen ctermfg=4 ctermbg=11 guifg=#268bd2 guibg=#edeea5 guisp=NONE cterm=NONE gui=NONE
hi ModeMsg ctermfg=2 ctermbg=10 guifg=#468747 guibg=#ebffeb guisp=NONE cterm=NONE gui=NONE
hi NonText ctermfg=8 ctermbg=NONE guifg=#878781 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Pmenu ctermfg=2 ctermbg=10 guifg=#468747 guibg=#ebffeb guisp=NONE cterm=NONE gui=NONE
hi PmenuSbar ctermfg=2 ctermbg=13 guifg=#468747 guibg=#96d197 guisp=NONE cterm=NONE gui=NONE
hi PmenuSel ctermfg=10 ctermbg=2 guifg=#ebffeb guibg=#468747 guisp=NONE cterm=NONE gui=NONE
hi PmenuThumb ctermfg=10 ctermbg=2 guifg=#ebffeb guibg=#468747 guisp=NONE cterm=NONE gui=NONE
hi Search ctermfg=0 ctermbg=12 guifg=#222222 guibg=#ebffff guisp=NONE cterm=NONE gui=NONE
hi StatusLine ctermfg=0 ctermbg=12 guifg=#222222 guibg=#ebffff guisp=NONE cterm=NONE gui=NONE
hi StatusLineNC ctermfg=0 ctermbg=7 guifg=#222222 guibg=#ffeaea guisp=NONE cterm=NONE gui=NONE
hi TabLine ctermfg=0 ctermbg=7 guifg=#222222 guibg=#ffeaea guisp=NONE cterm=NONE gui=NONE
hi TabLineFill ctermfg=0 ctermbg=7 guifg=#222222 guibg=#ffeaea guisp=NONE cterm=NONE gui=NONE
hi TabLineSel ctermfg=0 ctermbg=12 guifg=#222222 guibg=#ebffff guisp=NONE cterm=NONE gui=NONE
hi Visual ctermfg=NONE ctermbg=11 guifg=NONE guibg=#edeea5 guisp=NONE cterm=NONE gui=NONE
hi WildMenu ctermfg=0 ctermbg=7 guifg=#222222 guibg=#ffeaea guisp=NONE cterm=NONE gui=NONE
hi! link ColorColumn CursorLine
hi! link Conceal Normal
hi! link CursorColumn CursorLine
hi! link ErrorMsg Error
hi! link FoldColumn LineNr
hi! link Question Comment
hi! link SignColumn Normal
hi! link VertSplit StatusLineNC
hi! link vimAutoCmdSfxList Type
hi! link vimIsCommand Statement
finish
