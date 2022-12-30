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
local spell_path = vim.fn.stdpath 'config' .. '/spell/en.utf-8.add'
local known_words_en = {}
for word in io.open(spell_path, 'r'):lines() do
  table.insert(known_words_en, word)
end
spell_path = vim.fn.stdpath 'config' .. '/spell/de.utf-8.add'
local known_words_de = {}
for word in io.open(spell_path, 'r'):lines() do
  table.insert(known_words_de, word)
end

local ltex_opts = {
    settings = {
        ltex = {
            language = "de-DE",
            disabledRules = {
                ['en-US'] = { 'PROFANITY' },
                ['en-GB'] = { 'PROFANITY' },
                ['de-DE'] = { 'PROFANITY' },
            },
            dictionary = {
                ['en-US'] = known_words_en,
                ['en-GB'] = known_words_en,
                ['de-DE'] = known_words_de,
            },
        }
    }
}
lsp.setup_servers({'ltex', opts = ltex_opts})
