local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    print "snippets.lua: unable to require luasnip!"
    return
end

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

local function new_snippet(filetype, snip_name, triggers, snippet)
    for _, trigger in pairs(triggers) do
        ls.add_snippets(filetype, {
            s({trig = trigger, name = snip_name}, vim.deepcopy(snippet))
        })
    end
end

new_snippet("tex", "glqq", {"glqq", "\\glqq"}, {
    t({"\\glqq "}), i(1), t({"\\grqq{}"})
})
