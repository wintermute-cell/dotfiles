local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    print "completion.lua: Unable to load cmp!"
    return
end

-- cmp setup (sources, bindings, ...)
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    sources = cmp.config.sources({
        -- order of sources indicates precedence!
        { name = 'nvim_lsp' }, -- suggest from lsp
        { name = 'ultisnips' }, -- suggest from ultisnips
        { name = 'nvim_lua' }, -- for suggestions while configuring nvim
    }, {
        { name = 'buffer' }, -- suggest from buffer
    }),
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- disable default
        ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
        }),
        ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        ['<CR>'] = cmp.config.disable,
    }),
    window = {
        -- define a custom border here
        documentation = true, -- { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, },
    },
})


-- Use buffer source for `/`
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline({}), -- use the default mappings for all types of cmdline completion
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({}),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
