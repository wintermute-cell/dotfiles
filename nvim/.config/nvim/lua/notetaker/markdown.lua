-------------------
-- TREESITTER -------
-------------------------------
local status_ok, ts_parsers = pcall(require, 'nvim-treesitter.parsers')
if not status_ok then
    print "markdown.lua: Unable to require nvim-treesitter.parsers!"
end

-- enable the markdown syntax parser for the 'telekasten' filetype
ts_parsers.filetype_to_parsername["telekasten"] = "markdown"

---------------------
-- MARKDOWN PREVIEW ---------
-------------------------------

-- basics
vim.g.mkdp_auto_start = 1        -- autostart preview when entering .md buffer -- TODO: Doesn't seem to work
vim.g.mkdp_auto_close = 1        -- autoclose preview when .md buffer is not visible
vim.g.mkdp_refresh_slow = 0      -- when set to 1, only refresh on save or on leaving insert mode

-- useless
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_browserfunc = ''     -- custom vim func to open preview. url is given as first arg

-- expose to network
vim.g.mkdp_open_to_the_world = 0 -- expose preview server on network
vim.g.mkdp_open_ip = ''          -- expose under custom ip

-- use a custom port to start server or empty for random
vim.g.mkdp_port = ''

-- other
vim.g.mkdp_browser = '/usr/bin/firefox' -- path to browser binary
vim.g.mkdp_echo_preview_url = 1         -- echo url when opening preview
vim.g.mkdp_filetypes = { 'markdown' }

-- visuals
vim.g.mkdp_markdown_css = '' -- custom markdown style css (absolute path) like '/home/username/markdown.css' or expand('~/markdown.css')
vim.g.mkdp_highlight_css = '' -- custom highlight style css (absolute path) like '/home/username/highlight.css' or expand('~/highlight.css')
vim.g.mkdp_page_title = '「${name}」' -- preview page title, can use ${name} for file name
vim.g.mkdp_theme = 'dark' -- dark or light

-- options for markdown render
-- mkit: markdown-it options for render
-- katex: katex options for math
-- uml: markdown-it-plantuml options
-- maid: mermaid options
-- disable_sync_scroll: if disable sync scroll, default 0
-- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
--   middle: mean the cursor position alway show at the middle of the preview page
--   top: mean the vim top viewport alway show at the top of the preview page
--   relative: mean the cursor position alway show at the relative positon of the preview page
-- hide_yaml_meta: if hide yaml metadata, default is 1
-- sequence_diagrams: js-sequence-diagrams options
-- content_editable: if enable content editable for preview page, default: v:false
-- disable_filename: if disable filename header for preview page, default: 0
vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
    disable_filename = 0,
    toc = {}
   }
