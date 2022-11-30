local opt = vim.opt
local mode = os.getenv("THEME_MODE")

if mode == nil or mode == '' then
    print "theme.lua: No color mode set!"
    return
end

opt.termguicolors = true        -- enable 24-bit RGB colors
if mode == 'plan9' then
    vim.cmd [[colorscheme plan9]]
elseif mode == 'monotone' then
    vim.cmd [[colorscheme monotone]]
elseif mode == 'flowver' then
    vim.cmd [[colorscheme flowver]]
end
