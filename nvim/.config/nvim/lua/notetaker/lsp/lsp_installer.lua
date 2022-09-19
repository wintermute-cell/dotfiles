local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
    print "lsp_installer.lua: unable to require nvim-lsp-installer!"
    return
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require('notetaker.lsp.handlers').on_attach,
        capabilities = require('notetaker.lsp.handlers').capabilities,
    }

    -- (optional) per LSP configurations
    -- for example:
    --    if server.name == "jsonls" then
    --        local jsonls_opts = require('notetaker.lsp.settings.jsonls')
    --        opts = vim.tbl_deep_extend('force', jsonls_opts, opts)
    --    end

    if server.name == "sumneko_lua" then
        local sumneko_lua_opts = require('shared.lsp.settings.sumneko_lua')
        opts = vim.tbl_deep_extend('force', sumneko_lua_opts, opts)
    end

    -- finalize by setting up the server with the provided opts
    server:setup(opts)
end)
