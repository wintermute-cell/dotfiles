local opt = vim.opt
local mode = os.getenv("THEME_MODE")

if mode == nil or mode == '' then
    print "theme.lua: No color mode set!"
    return
end

opt.termguicolors = true        -- enable 24-bit RGB colors
if mode == 'plan9' then
    vim.cmd [[colorscheme plan9]]   -- setting the colorscheme (plan9, monotone)
elseif mode == 'monotone' then
    vim.cmd [[colorscheme monotone]]   -- setting the colorscheme (plan9, monotone)
end

