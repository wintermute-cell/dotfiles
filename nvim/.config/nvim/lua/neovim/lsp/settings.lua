-- settings for individual Language Servers
local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
    print "lsp/settings.lua: Unable to require lsp-zero!"
    return
end

-- sumneko_lua
local sumneko_lua_opts = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true
                }
            }
        }
    }

}
lsp.setup_servers({'sumneko_lua', opts = sumneko_lua_opts})

-- ltex
local ltex_opts = {
    settings = {
        ltex = {
            language = "de"
        }
    }
}
lsp.setup_servers({'ltex', opts = ltex_opts})
