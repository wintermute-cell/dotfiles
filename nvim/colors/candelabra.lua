-- #0D0D0D
-- #404040
-- #8C8C8C
-- #F2F2F2
-- #80a0ff

local appy_colorscheme = function()
  -- remove current colorscheme

  vim.cmd 'hi clear'

  -- Define colors
  local colors = {
    t = 'NONE',
    bg = '#151515',
    fg = '#F2F2F2',
    fg_dim = '#8C8C8C',
    dark_gray = '#404040',
    accent = '#80A0FF',
    black = '#0D0D0D',

    good = '#95AA6B',
    info = '#768F80',
    warning = '#E39C45',
    error = '#CF223E',
  }
  vim.g.terminal_color_0 = '#1A1515'
  vim.g.terminal_color_1 = '#F07342'
  vim.g.terminal_color_2 = '#768F80'
  vim.g.terminal_color_3 = '#959A6B'
  vim.g.terminal_color_4 = '#E39C45'
  vim.g.terminal_color_5 = '#CF223E'
  vim.g.terminal_color_6 = '#756D94'
  vim.g.terminal_color_7 = '#DCC9BC'
  vim.g.terminal_color_8 = '#725a5a'
  vim.g.terminal_color_9 = '#F07342'
  vim.g.terminal_color_10 = '#768F80'
  vim.g.terminal_color_11 = '#959A6B'
  vim.g.terminal_color_12 = '#E39C45'
  vim.g.terminal_color_13 = '#CF223E'
  vim.g.terminal_color_14 = '#756D94'
  vim.g.terminal_color_15 = '#7B3D79'

  -- Helper function to set highlight
  local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Editor settings
  hi('Normal', { fg = colors.fg, bg = colors.t })
  hi('Cursor', { fg = colors.fg, bg = colors.t })
  hi('CursorLine', { bg = colors.t })
  hi('LineNr', { fg = colors.dark_gray, bg = colors.t })
  hi('CursorLineNR', { bg = colors.t })

  -- Number column
  hi('CursorColumn', { bg = colors.t })
  hi('FoldColumn', { fg = colors.dark_gray, bg = colors.t })
  hi('SignColumn', { fg = colors.dark_gray, bg = colors.t })
  hi('Folded', { fg = colors.dark_gray, bg = colors.t })

  -- Window/Tab delimiters
  hi('VertSplit', { bg = colors.t })
  hi('ColorColumn', { bg = colors.black })
  hi('TabLine', { bg = colors.t })
  hi('TabLineFill', { bg = colors.t })
  hi('TabLineSel', { bg = colors.t })

  -- File Navigation / Searching
  hi('Directory', { fg = colors.fg, bg = colors.t })
  hi('Search', { fg = colors.black, bg = colors.accent })
  hi('IncSearch', { fg = colors.black, bg = colors.accent })

  -- Prompt/Status
  hi('StatusLine', { fg = colors.fg_dim, bg = colors.t })
  hi('StatusLineNC', { fg = colors.accent, bg = colors.t })
  hi('WildMenu', { fg = colors.accent, bg = colors.t })
  hi('Question', { fg = colors.dark_gray, bg = colors.t })
  hi('ModeMsg', { fg = colors.dark_gray, bg = colors.t })
  hi('MoreMsg', { fg = colors.accent, bg = colors.t })
  hi('Title', { fg = colors.fg, bg = colors.t })

  -- Visual aid
  hi('MatchParen', { fg = colors.accent, bg = colors.dark_gray })
  hi('Visual', { fg = colors.fg, bg = colors.dark_gray })
  hi('VisualNOS', { fg = colors.fg, bg = colors.dark_gray })
  hi('NonText', { bg = colors.t })

  -- Spelling
  hi('SpellBad', { fg = colors.accent, bg = colors.t })
  hi('SpellCap', { fg = colors.fg, bg = colors.t })
  hi('SpellLocal', { fg = colors.fg, bg = colors.t })
  hi('SpellRare', { fg = colors.fg, bg = colors.t })

  -- Error handling
  hi('Todo', { fg = colors.fg, bg = colors.t, italic = true })
  hi('Underlined', { fg = colors.fg, bg = colors.t, underline = true })
  hi('Error', { fg = colors.error, bg = colors.t })
  hi('ErrorMsg', { fg = colors.error, bg = colors.t })
  hi('WarningMsg', { fg = colors.warning, bg = colors.t })
  hi('Ignore', { fg = colors.fg_dim, bg = colors.t })
  hi('SpecialKey', { fg = colors.fg_dim, bg = colors.t })
  hi('WhiteSpaceChar', { fg = colors.dark_gray, bg = colors.t })
  hi('WhiteSpace', { fg = colors.dark_gray, bg = colors.t })

  -- Variable types
  hi('Constant', { fg = colors.fg_dim, bg = colors.t })
  hi('String', { fg = colors.fg_dim, bg = colors.t, italic = true })
  hi('StringDelimiter', { fg = colors.fg_dim, bg = colors.t })
  hi('Character', { fg = colors.fg_dim, bg = colors.t })
  hi('Number', { fg = colors.fg_dim, bg = colors.t })
  hi('Boolean', { fg = colors.fg_dim, bg = colors.t })
  hi('Float', { fg = colors.fg_dim, bg = colors.t })

  hi('Identifier', { fg = colors.fg, bg = colors.t })
  hi('Function', { fg = colors.fg, bg = colors.t })

  -- Language constructs
  hi('Statement', { fg = colors.fg, bg = colors.t })
  hi('Conditional', { fg = colors.fg, bg = colors.t })
  hi('Repeat', { fg = colors.fg, bg = colors.t })
  hi('Label', { fg = colors.fg, bg = colors.t })
  hi('Operator', { fg = colors.fg, bg = colors.t })
  hi('Keyword', { fg = colors.fg, bg = colors.t })
  hi('Exception', { fg = colors.fg, bg = colors.t })
  hi('Comment', { fg = colors.dark_gray, bg = colors.t, italic = true })

  -- Special
  hi('Special', { fg = colors.fg, bg = colors.t })
  hi('SpecialChar', { fg = colors.fg, bg = colors.t })
  hi('Tag', { fg = colors.fg, bg = colors.t })
  hi('Delimiter', { fg = colors.fg, bg = colors.t })
  hi('SpecialComment', { fg = colors.fg, bg = colors.t })
  hi('Debug', { fg = colors.fg, bg = colors.t })

  -- C-like
  hi('PreProc', { fg = colors.fg, bg = colors.t })
  hi('Include', { fg = colors.fg, bg = colors.t })
  hi('Define', { fg = colors.fg, bg = colors.t })
  hi('Macro', { fg = colors.fg, bg = colors.t })
  hi('PreCondit', { fg = colors.fg, bg = colors.t })

  hi('Type', { fg = colors.fg, bg = colors.t })
  hi('StorageClass', { fg = colors.fg, bg = colors.t })
  hi('Structure', { fg = colors.fg, bg = colors.t })
  hi('Typedef', { fg = colors.fg, bg = colors.t })

  -- Diff
  hi('DiffAdd', { fg = colors.good, bg = colors.t })
  hi('DiffChange', { fg = colors.info, bg = colors.t })
  hi('DiffDelete', { fg = colors.error, bg = colors.t })
  hi('DiffText', { fg = colors.fg, bg = colors.t })

  -- Completion menu
  hi('Pmenu', { fg = colors.fg_dim, bg = colors.bg })
  hi('PmenuSel', { fg = colors.black, bg = colors.accent })
  hi('PmenuSbar', { fg = colors.fg_dim, bg = colors.bg })
  hi('PmenuThumb', { fg = colors.fg_dim, bg = colors.bg })

  -- [[ Diagnostics ]]
  hi('DiagnosticError', { bg = colors.t, fg = colors.error })
  hi('DiagnosticWarn', { bg = colors.t, fg = colors.warning })
  hi('DiagnosticInfo', { bg = colors.t, fg = colors.info })
  hi('DiagnosticHint', { bg = colors.t, fg = colors.fg_dim })
  hi('DiagnosticOk', { bg = colors.t, fg = colors.good })
  hi('DiagnosticUnderlineError', { bg = colors.t, fg = colors.fg, undercurl = true, sp = colors.error })
  hi('DiagnosticUnderlineWarn', { bg = colors.t, fg = colors.fg, undercurl = true, sp = colors.warning })
  hi('DiagnosticUnderlineInfo', { bg = colors.t, fg = colors.fg, undercurl = true, sp = colors.info })
  hi('DiagnosticUnderlineHint', { bg = colors.t, fg = colors.fg, undercurl = true, sp = colors.fg_dim })
  hi('DiagnosticUnderlineOk', { bg = colors.t, fg = colors.fg, undercurl = true, sp = colors.good })
  hi('StatusLineDiagnosticError', { bg = colors.t, fg = colors.error })

  -- [[ Floating Window ]]
  hi('FloatShadow', { bg = colors.bg })
  hi('FloatShadowThrough', { bg = colors.t })
end

appy_colorscheme()
