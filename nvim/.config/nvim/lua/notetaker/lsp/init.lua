local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print "lsp/init.lua: Unable to require lspconfig!"
    return
end

require('notetaker.lsp.lsp_installer')
require('notetaker.lsp.handlers')
