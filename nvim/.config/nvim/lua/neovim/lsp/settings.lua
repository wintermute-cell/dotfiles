-- settings for individual Language Servers
local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
    print "lsp/settings.lua: Unable to require lsp-zero!"
    return
end

-- sumneko_lua
lsp.configure('lua_ls', {
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
})

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

lsp.configure('ltex', {
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
})

-- godot
lsp.configure('gdscript', {
    force_setup = true, -- because the LSP is global. Read more on lsp-zero docs about this.
    single_file_support = false,
    root_dir = require('lspconfig.util').root_pattern('project.godot', '.git'),
    filetypes = {'gd', 'gdscript', 'gdscript3' }
})
