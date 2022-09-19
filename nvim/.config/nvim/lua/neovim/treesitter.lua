local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    print "treesitter.lua: Unable to require nvim-treesitter.configs!"
end

configs.setup {
    ensure_installed = { '' },                     -- one of "all", "maintained" (parsers with maintainers) or list of langs
    sync_install = false,                         -- for 'ensure_installed', install asyncronously
    auto_install = true,                          -- auto-install missing parsers when entering buffer
    ignore_install = { '' },                      -- don't use for languages from this list
    highlight = {
        enable = true,                            -- highlight based on treesitter
        disable = { '' },                         -- list of languages to disable treesitter-highlighting for
        additional_vim_regex_highlighting = true, -- use vims old regex based system as well
    },
    indent = {
        enable = true,                            -- indent based on treesitter
        disable = { '' },                         -- disable treesitter indent for these langs
    },
    fold = {
        fold_one_line_after = true,
    },
}
