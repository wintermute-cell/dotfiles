local M = {} -- will be returned/exported at the end

---------------
-- ON_ATTACH -------------
------------------------------
-- define keymaps and command definitions
local function setup_lsp_keymaps(bufnr)
    -- some shorthands
    local function keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- LSP KEYMAPS
    -- jumping
    keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- help
    keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "g?", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    --utility
    keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    keymap("n", "<leader>lp", '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    keymap("n", "<leader>ln", '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    -- workspaces
    keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    -- custom :Format command
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()']]
end


-- attach to return value
M.on_attach = function(client, bufnr)
    setup_lsp_keymaps(bufnr)
end

---------------
-- CAPABILITIES ----------
------------------------------
-- make basic capabilities
local c = vim.lsp.protocol.make_client_capabilities()

-- check if cmp_nvim_lsp can be required, and if so, update_capabilites with it
local status_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
    print "handlers.lua: Unable to require cmp_nvim_lsp, loading lsp without cmp!"
else
    c = cmp_lsp.update_capabilities(c)
end

-- attach to return value
M.capabilities = c


-------------
-- RETURN --------
------------------------------
return M
