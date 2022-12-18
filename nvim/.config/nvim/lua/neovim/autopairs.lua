local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
    print "autopairs.lua: unable to require nvim-autopairs!"
    return
end

npairs.setup {
    check_ts = true,
    ts_config = {
        -- don't place pairs on these nodes
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
    },
    disable_filetype = { "TelescopePrompt" },
}

local cmp_npairs = require "nvim-autopairs.completion.cmp"
local handlers = require('nvim-autopairs.completion.handlers')
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    print "autopairs.lua: unable to require cmp!"
    return
end
cmp.event:on('confirm_done', cmp_npairs.on_confirm_done({
    filetypes = {
      ["*"] = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          handler = handlers["*"]
        }
      },
      tex = {
        ["{"] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method
          },
          handler = handlers["*"]
        }
      },
    }
  })
)
