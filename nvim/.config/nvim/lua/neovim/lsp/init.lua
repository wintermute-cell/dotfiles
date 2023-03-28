local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
    print "lsp/init.lua: Unable to require lsp-zero!"
    return
end

lsp.preset("recommended")

lsp.ensure_installed({
    'bashls',       -- bash
    'clangd',       -- C/C++
    'cssls',        -- CSS
    'dockerls',     -- docker
    'gopls',        -- golang
    'html',         -- HTML
    'jsonls',       -- json
    'tsserver',     -- javascript/typescript (js/ts)
    'ltex',         -- LaTeX
    'marksman',     -- markdown
    'sqlls',        -- sql
    'svelte',       -- svelte
    'yamlls'        -- yaml
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    ['<CR>'] = cmp.config.disable,
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<S-Tab>'] = nil,
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
      {name = 'path'},
      {name = 'nvim_lsp', keyword_length = 3},
      {name = 'buffer', keyword_length = 3, option = { keyword_pattern = [[\k\+]] }}, -- pattern allows for umlauts in completions
      {name = 'luasnip', keyword_length = 2},
  },
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

vim.diagnostic.config({
    virtual_text = true,
})

require 'neovim.lsp.settings'

lsp.setup()
