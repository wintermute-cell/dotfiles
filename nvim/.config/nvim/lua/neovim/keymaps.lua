local status_ok, wk = pcall(require, 'which-key')
if not status_ok then
    print "keymaps.lua: Unable to require which-key!"
end
local status_ok, lsp = pcall(require, "lsp-zero") -- required for lsp mappings
if not status_ok then
    print "keymaps.lua: Unable to require lsp-zero!"
    return
end
local keymap = vim.keymap.set -- shorthand
table.unpack = table.unpack or unpack  -- fix usage of deprecated unpack

-- mapping leader key
keymap("", "<Space>", "<Nop>")
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
wk.register({["<leader>o"] = {name = "+helper windows"}})
keymap("n", "<leader>ou", vim.cmd.UndotreeToggle, {desc = 'Open Undotree'})
keymap("n", "<leader>oe", function () -- opening Lexplore 30 sets the width to
    vim.cmd.Lexplore()                -- 30%, so this is necessary
    if vim.bo.filetype == 'netrw' then
        vim.api.nvim_win_set_width(0, 30)
    end
end, {desc = 'Explore Files'})

-- telescope.nvim
local tsb = require('telescope.builtin')
wk.register({["<leader>f"] = {name = "+telescope"}})
keymap("n", "<leader>ff", tsb.find_files, {desc = 'find files'})
keymap("n", "<leader>fg", tsb.live_grep, {desc = 'live grep'})
keymap("n", "<leader>fs", tsb.live_grep, {desc = 'grep for string at cursor'})
keymap("n", "<leader>fb", tsb.buffers, {desc = 'find buffers'})
keymap("n", "<leader>fh", tsb.help_tags, {desc = 'find helptags'})

-- resizing with ctrl+arrows
keymap("n", "<C-Up>", ":resize +2<CR>")
keymap("n", "<C-Down>", ":resize -2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- better buffer navigation with SHIFT+H/L
local function bnav_skip(command)
    repeat command() until (vim.bo.buftype ~= 'quickfix' and vim.bo.buftype ~= 'terminal')
end
keymap("n", "<S-h>", function () bnav_skip(vim.cmd.bprevious) end)
keymap("n", "<S-l>", function () bnav_skip(vim.cmd.bnext) end)

-- deleting buffers without closing splits with moll/vim-bbye
local function bd_skip(command)
    command()
    repeat vim.cmd.bnext() until (vim.bo.buftype ~= 'quickfix' and vim.bo.buftype ~= 'terminal')
end
keymap("n", "<leader>bd", function () bd_skip(vim.cmd.Bdelete) end, {desc = 'delete buffer without closing split'})
keymap("n", "<leader>bw", function () bd_skip(vim.cmd.Bwipeout) end, {desc = 'wipeout buffer without closing split'})

-- better vertical movement/navigation
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- disabling some features
keymap("n", "Q", "<Nop>")
keymap("n", "q:", "<Nop>")

-- easy plus register
keymap("n", "<leader>y", "\"+y", {desc = 'yank to +'})

-- LSP related keymaps
-- defined in on_attach, so they are only active when functions are available
-- and otherwise vim builtins are used
wk.register({["<leader>k"] = {name = "+lsp"}})
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- LEFT IN AS AN EXAMPLE:
  --if client.name == "eslint" then
  --    vim.cmd [[ LspStop eslint ]]
  --    return
  --end

  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "[d", vim.diagnostic.goto_next, opts)
  keymap("n", "]d", vim.diagnostic.goto_prev, opts)
  keymap("n", "zn", vim.diagnostic.goto_next, {desc = 'next diagnostic', table.unpack(opts)})
  keymap("n", "zp", vim.diagnostic.goto_prev, {desc = 'previous diagnostic', table.unpack(opts)})
  keymap("n", "<leader>kd", vim.diagnostic.open_float, {desc = 'float diagnostic', table.unpack(opts)})
  keymap("n", "<leader>ka", vim.lsp.buf.code_action, {desc = 'code action', table.unpack(opts)})
  keymap("n", "<leader>kr", vim.lsp.buf.references, {desc = 'references', table.unpack(opts)})
  keymap("n", "<leader>kn", vim.lsp.buf.rename, {desc = 'rename', table.unpack(opts)})
  keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts)
end)

-------------
-- VISUAL MODE --
------------------------------
keymap("v", "<leader>y", "\"+y", {desc = 'yank to +'})

-------------
-- VISUAL BLOCK --
------------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv=gv")
keymap("x", "K", ":move '<-2<CR>gv=gv")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

keymap("x", "<leader>y", "\"+y", {desc = 'yank to +'})

-------------
-- TERMINAL ------
------------------------------
local term_opts = { silent = true }
-- Better terminal navigation
keymap("t", "<C-w>h", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-w>j", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-w>k", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-w>l", "<C-\\><C-N><C-w>l", term_opts)
