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
        custom_captures = {
            ["h1"] = "mdH1Text",
            ["_h1"] = "mdH1Prefix",
            ["h2"] = "mdH2Text",
            ["_h2"] = "mdH2Prefix",
            ["h3"] = "mdH3Text",
            ["_h3"] = "mdH3Prefix",
            ["h4"] = "mdH4Text",
            ["_h4"] = "mdH4Prefix",
            ["h5"] = "mdH5Text",
            ["_h5"] = "mdH5Prefix",
        },
    },
    indent = {
        enable = true,                            -- indent based on treesitter
        disable = { '' },                         -- disable treesitter indent for these langs
    },
    fold = {
        fold_one_line_after = true,
    },
    -- extensions
    rainbow = {
        enable = true,                            -- enable rainbow parentheses
        --disable = { 'cpp', 'jsx' },             -- don't use rainbow parens for these langs
        extended_mode = true,                     -- also color things like curly braces, brackets, html tags, ...
        max_file_lines = nil,                     -- don't enable with more than n lines
        --colors = {},                            -- a table of custom hex colors
        --termcolors = {},                        -- a table of custom color name strings
    }
}
