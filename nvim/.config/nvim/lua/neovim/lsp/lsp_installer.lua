-- MASON
local status_ok_mason, mason = pcall(require, 'mason')
if not status_ok_mason then
    print "lsp_installer.lua: unable to require mason!"
    return
end

mason.setup()

-- MASON_LSPCONFIG
local status_ok_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok_lspconfig then
    print "lsp_installer.lua: unable to require mason_lspconfig!"
    return
end

mason_lspconfig.setup({
    ensure_installed = {
        'bashls',       -- bash
        'clangd',       -- C/C++
        'cssls',        -- CSS
        'dockerls',     -- docker
        'gopls',        -- golang
        'html',         -- HTML
        'jsonls',       -- json
        'tsserver',     -- javascript/typescript (js/ts)
        'ltex',         -- LaTeX
        'sumneko_lua',  -- lua
        'marksman',     -- markdown
        'pylsp',        -- python
        'sqlls',        -- sql
        'svelte',       -- svelte
        'yamlls'        -- yaml
    },
    automatic_installation = true,
})

mason_lspconfig.setup_handlers({
    function(server_name)
        local opts = {
            on_attach = require('neovim.lsp.handlers').on_attach,
            capabilities = require('neovim.lsp.handlers').capabilities,
        }

        -- (optional) per LSP configurations
        -- for example:
        --    if server.name == "jsonls" then
        --        local jsonls_opts = require('neovim.lsp.settings.jsonls')
        --        opts = vim.tbl_deep_extend('force', jsonls_opts, opts)
        --    end

        if server_name == "sumneko_lua" then
            local sumneko_lua_opts = require('shared.lsp.settings.sumneko_lua')
            opts = vim.tbl_deep_extend('force', sumneko_lua_opts, opts)
        end

        if server_name == "ltex" then
            opts.settings = {
                ltex = {
                    language = "de"
                }
            }
        end

        require('lspconfig')[server_name].setup(opts)
    end
})
