local opt = vim.opt

-------------
-- GENERAL ---------
------------------------------
opt.fileencoding = "utf-8"
-- opt.clipboard = 'unnamedplus'   -- use system clipboard
opt.timeoutlen = 800            -- time to wait for sequence to compelete in ms
opt.undofile = true             -- enable persistent undos
opt.backup = false              -- make a permanent backup file
opt.writebackup = true          -- make a temp backup during file writing
opt.title = true                -- make the window-title dynamic
-- disable automatic comment continuation on newline
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-------------
-- TUI -------------
------------------------------
opt.number = true               -- show absolute line number at cursor line
opt.relativenumber = true       -- show relative line numbers
opt.showmatch = true            -- highlight matching parens
opt.foldmethod = 'expr'         -- enable folding (default 'foldmarker')
opt.foldlevel = 9999            -- open a file fully expanded
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
opt.fillchars = "fold: "        -- use space as a filler after a fold
opt.colorcolumn = '80'          -- line lenght marker at 80 columns
opt.splitright = true           -- vertical split to the right
opt.splitbelow = true           -- horizontal split to the bottom
opt.ignorecase = true           -- ignore case letters when search
opt.smartcase = true            -- ignore lowercase for the whole pattern
opt.linebreak = true            -- wrap on word boundary
opt.conceallevel = 0            -- never conceal anything by default
opt.signcolumn = "yes"          -- always show sign column; prevent shifting
opt.scrolloff = 10              -- <3

-------------
-- USAGE -----------
------------------------------
vim.cmd [[set iskeyword+=-]]    -- treat '-' as part of a word

-------------
-- INDENTATION -----
------------------------------
opt.expandtab = true            -- use spaces instead of tabs
opt.shiftwidth = 4              -- shift 4 spaces when tab
opt.tabstop = 4                 -- 1 tab == 4 spaces
opt.smartindent = true          -- autoindent new lines

-------------
-- COMPLETION -----
------------------------------
opt.completeopt = { 'menuone', 'noinsert' }
opt.pumheight = 10              -- height of the completion popup menu
--opt.wildmenu = true           -- use vims builtin cmdline completion (not compatible with nvim-cmp!)
--opt.wildmode = { 'longest', 'list', 'full' }

-------------
-- PERFORMANCE -----
------------------------------
opt.hidden = true               -- enable background buffers
opt.history = 500               -- remember N lines in history
opt.lazyredraw = true           -- faster scrolling
opt.synmaxcol = 240             -- max column for syntax highlight
opt.updatetime = 300            -- ms to wait to trigger an event

-------------
-- STARTUP --------
------------------------------
opt.shortmess:append "sI"       -- Disable nvim intro
