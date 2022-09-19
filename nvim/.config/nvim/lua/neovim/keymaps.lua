local dopts = { noremap = true, silent = true } -- default opts, should fit most
local keymap = vim.api.nvim_set_keymap -- shorthand


-- mapping leader key
keymap("", "<Space>", "<Nop>", dopts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------
-- HINT ----------
------------------------------
--    Modes  |  shorthand
--    normal:       "n"
--    insert:       "i"
--    visual:       "v"
--    visual_block: "x"
--    term:         "t"
--    command:      "c"

-------------
-- NORMAL --------
------------------------------
-- vanilla leader mappings
keymap("n", "<leader>e", ":Lex 30<CR>", dopts)

-- telescope.nvim
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", dopts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", dopts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", dopts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", dopts)

-- telekasten
keymap("n", "<leader>zf", "<cmd>lua require('telekasten').find_notes()<CR>", dopts)
keymap("n", "<leader>zd", "<cmd>lua require('telekasten').find_daily_notes()<CR>", dopts)
keymap("n", "<leader>zg", "<cmd>lua require('telekasten').search_notes()<CR>", dopts)
keymap("n", "<leader>zz", "<cmd>lua require('telekasten').follow_link()<CR>", dopts)
keymap("n", "<leader>zT", "<cmd>lua require('telekasten').goto_today()<CR>", dopts)
keymap("n", "<leader>zW", "<cmd>lua require('telekasten').goto_thisweek()<CR>", dopts)
keymap("n", "<leader>zw", "<cmd>lua require('telekasten').find_weekly_notes()<CR>", dopts)
keymap("n", "<leader>zn", "<cmd>lua require('telekasten').new_note()<CR>", dopts)
keymap("n", "<leader>zN", "<cmd>lua require('telekasten').new_templated_note()<CR>", dopts)
keymap("n", "<leader>zy", "<cmd>lua require('telekasten').yank_notelink()<CR>", dopts)
keymap("n", "<leader>zc", "<cmd>lua require('telekasten').show_calendar()<CR>", dopts)
keymap("n", "<leader>zi", "<cmd>lua require('telekasten').paste_img_and_link()<CR>", dopts)
keymap("n", "<leader>zt", "<cmd>lua require('telekasten').toggle_todo()<CR>", dopts)
keymap("n", "<leader>zb", "<cmd>lua require('telekasten').show_backlinks()<CR>", dopts)
keymap("n", "<leader>zF", "<cmd>lua require('telekasten').find_friends()<CR>", dopts)
keymap("n", "<leader>zI", "<cmd>lua require('telekasten').insert_img_link({ i=true })<CR>", dopts)
keymap("n", "<leader>zp", "<cmd>lua require('telekasten').preview_img()<CR>", dopts)
keymap("n", "<leader>zm", "<cmd>lua require('telekasten').browse_media()<CR>", dopts)
keymap("n", "<leader>za", "<cmd>lua require('telekasten').show_tags()<CR>", dopts)
keymap("n", "<leader>z#", "<cmd>lua require('telekasten').show_tags()<CR>", dopts)
keymap("n", "<leader>zr", "<cmd>lua require('telekasten').rename_note()<CR>", dopts)

keymap("n", "<leader>z", "<cmd>lua require('telekasten').panel()<CR>", dopts)

keymap("i", "<C-c><C-n>", "<cmd>lua require('telekasten').insert_link({ i=true })<CR>", dopts)
keymap("i", "<C-c><C-t>", "<cmd>lua require('telekasten').show_tags({i = true})<CR>", dopts)

-- resizing with ctrl+arrows
keymap("n", "<C-Up>", ":resize +2<CR>", dopts)
keymap("n", "<C-Down>", ":resize -2<CR>", dopts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", dopts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", dopts)

-- better buffer navigation with SHIFT+H/L
keymap("n", "<S-h>", ":bprevious<CR>", dopts)
keymap("n", "<S-l>", ":bnext<CR>", dopts)

keymap("n", "Q", "<Nop>", dopts)
keymap("n", "q:", "<Nop>", dopts)

-------------
-- VISUAL --------
------------------------------
-- Move text up and down with ALT+j/k
keymap("v", "<A-j>", ":m .+1<CR>==", dopts)
keymap("v", "<A-k>", ":m .-2<CR>==", dopts)

-- don't overwrite register / yank by pasting over something
keymap("v", "p", '"_dP', dopts)

-------------
-- VISUAL BLOCK --
------------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", dopts)
keymap("x", "K", ":move '<-2<CR>gv-gv", dopts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", dopts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", dopts)

-------------
-- TERMINAL ------
------------------------------
local term_opts = { silent = true }
-- Better terminal navigation
keymap("t", "<C-w>h", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-w>j", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-w>k", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-w>l", "<C-\\><C-N><C-w>l", term_opts)
















