--[[

                                           ||
        .. ...     ....    ...   .... ... ...  .. .. ..
         ||  ||  .|...|| .|  '|.  '|.  |   ||   || || ||
         ||  ||  ||      ||   ||   '|.|    ||   || || ||
        .||. ||.  '|...'  '|..|'    '|    .||. .|| || ||.

====================================================================
====================================================================

]]
local opt = vim.opt

----------------
-- GENERAL ----------
------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
opt.fileencoding = 'utf-8'
vim.g.have_nerd_font = true
opt.timeoutlen = 300
opt.undofile = true
opt.backup = false -- make a permanent backup file
opt.writebackup = true -- make a temp backup during file writing
opt.title = true -- make the window-title dynamic
vim.cmd 'autocmd BufEnter * setlocal formatoptions-=cro' -- disable automatic comment continuation on newline

-------------
-- TUI -------------
------------------------------
opt.number = true -- show absolute line number at cursor line
opt.relativenumber = true -- show relative line numbers
opt.showmatch = true -- highlight matching parens
opt.foldmethod = 'expr' -- enable folding (default 'foldmarker')
opt.foldlevel = 9999 -- open a file fully expanded
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
---@diagnostic disable-next-line
opt.fillchars = 'fold: ' -- use space as a filler after a fold
opt.colorcolumn = '80' -- line length marker at 80 columns
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- horizontal split to the bottom
opt.ignorecase = true -- ignore case when searching, except with \C
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.linebreak = true -- wrap on word boundary
opt.breakindent = true
opt.conceallevel = 0 -- never conceal anything by default
opt.signcolumn = 'yes' -- always show sign column; prevent shifting
opt.scrolloff = 20 -- <3
opt.showmode = false -- no mode change message in `messages`
opt.list = true -- display certain whitespace chars
opt.listchars = { -- how to display certain whitespace chars
  trail = '~',
  nbsp = '␣',
  tab = '  ',
}
opt.inccommand = 'split' -- preview s/ substitutions live, as you type!
opt.hlsearch = true -- highlight on search
opt.laststatus = 3 -- global statusline at the bottom
vim.opt.termguicolors = true -- use full RGB colors
vim.api.nvim_create_autocmd('TextYankPost', { -- highlight when yanking (copying) text
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- opt.background = 'dark'
-- vim.cmd.colorscheme 'base16-black-metal-burzum'

-- vim.cmd.colorscheme 'deepflowv'
-- vim.cmd.colorscheme 'biscuit'
--vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]] -- transparent background
--vim.cmd.colorscheme 'candelabra'
opt.background = 'light'
-- opt.background = 'dark'

-------------
-- NEOVIDE -----------
------------------------------
vim.o.guifont = 'mononoki:h12' -- set the font for Neovide
vim.g.neovide_padding_top = 4
vim.g.neovide_padding_bottom = 4
vim.g.neovide_padding_right = 4
vim.g.neovide_padding_left = 4
vim.g.neovide_scroll_animation_length = 0.15

-------------
-- NETRW -----------
------------------------------

-- `p` previews files in a
vim.g.netrw_preview = 1 -- ... vertical split
vim.g.netrw_alto = 0 -- ... to the right.

vim.g.netrw_liststyle = 1 -- long listing style (w/ time and size)
vim.g.netrw_sizestyle = 'H' -- human readable sizes

---------------
-- TERMINAL -----------
------------------------------
-- alternative to <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- exit terminal mode in the builtin terminal
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- exit terminal mode in the builtin terminal

opt.shell = 'fish'
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.cmd.startinsert()
  end,
})

-- local terminal_buf = nil
-- vim.api.nvim_create_autocmd('ExitPre', {
--   pattern = '*',
--   callback = function()
--     -- Create blocking buffer
--     local buf = vim.api.nvim_create_buf(false, false)
--     vim.api.nvim_buf_set_option(buf, 'modified', true)
--
--     vim.schedule(function()
--       -- Check if terminal buffer exists and is valid
--       if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
--         -- Switch to existing terminal
--         vim.api.nvim_set_current_buf(terminal_buf)
--       else
--         -- Create new terminal and store reference
--         vim.cmd 'enew'
--         vim.fn.termopen(vim.o.shell)
--         terminal_buf = vim.api.nvim_get_current_buf()
--       end
--       vim.cmd 'startinsert'
--     end)
--   end,
-- })

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    -- Send alias command to the terminal
    vim.api.nvim_chan_send(vim.b.terminal_job_id, 'alias nvim="nvr"\n')
    vim.api.nvim_chan_send(vim.b.terminal_job_id, 'alias vim="nvr"\n')
  end,
})

-------------
-- USAGE -----------
------------------------------
vim.cmd [[set iskeyword+=-]] -- treat '-' as part of a word
vim.opt.mouse = 'a' -- mouse mode enabled (resize splits, etc...)

-------------
-- INDENTATION -----
------------------------------
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.softtabstop = 4
opt.smartindent = true -- autoindent new lines
vim.api.nvim_create_autocmd('FileType', { -- only 2 spaces indent on these filetypes
  pattern = { 'html', 'templ', 'nix', 'lua', 'css', 'typescriptreact' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})
vim.api.nvim_create_autocmd('FileType', { -- use tabs for Go, as per the language convention
  pattern = { 'go' },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-------------
-- COMPLETION -----
------------------------------
opt.pumheight = 10 -- height of the completion popup menu

-------------
-- PERFORMANCE -----
------------------------------
opt.hidden = true -- enable background buffers
opt.history = 500 -- remember N lines in history
opt.synmaxcol = 240 -- max column for syntax highlight
opt.updatetime = 250 -- ms to wait to trigger an event

-------------
-- STARTUP --------
------------------------------
--opt.shortmess:append 'sI' -- Disable nvim intro

-------------
-- LANGUAGES -------
------------------------------
vim.filetype.add { extension = { templ = 'templ' } }

-------------
--  KEYMAPS  -------
------------------------------

-- do :noh on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
local function jumpfunc(count)
  return function()
    vim.diagnostic.jump { count = count, float = true }
  end
end
vim.keymap.set('n', '[d', jumpfunc(-1), { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', jumpfunc(1), { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- better vertical movement/navigation
-- NOTE: zz re-centers the screen, the scrolloff swap is there because for some
-- reason, ctrl-d scrolls by the normal amount PLUS the scrolloff, but only
-- when starting at the top.
-- vim.keymap.set('n', '<C-d>', ':set scrolloff=0<CR><C-d>:set scrolloff=20<CR>zz')
-- vim.keymap.set('n', '<C-u>', ':set scrolloff=0<CR><C-u>:set scrolloff=20<CR>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- disabling some features
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', 'q:', '<Nop>')

-- Better terminal navigation (auto escape terminal command mode and then switch)
local term_opts = { silent = true }
vim.keymap.set('t', '<C-w>h', '<C-\\><C-N><C-w>h', term_opts)
vim.keymap.set('t', '<C-w>j', '<C-\\><C-N><C-w>j', term_opts)
vim.keymap.set('t', '<C-w>k', '<C-\\><C-N><C-w>k', term_opts)
vim.keymap.set('t', '<C-w>l', '<C-\\><C-N><C-w>l', term_opts)

------------------------
--   PER PROJECT CONFIG   -------
---------------------------------------
local project_configs = {
  ['src/jamegam2025'] = function()
    vim.cmd [[set makeprg=task]]
  end,
}

vim.api.nvim_create_augroup('ProjectSpecificConfig', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'ProjectSpecificConfig',
  callback = function()
    local cwd = vim.fn.getcwd()
    for pattern, config_fn in pairs(project_configs) do
      if string.match(cwd, pattern) then
        config_fn()
        break
      end
    end
  end,
})

----------------
--  PLUGINS  -------
-------------------------------

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.print 'Bootstrapping lazy.nvim...'
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to clone lazy.nvim:\n\n' .. out .. '\n\nPress any key to exit...', vim.log.levels.ERROR, {
      title = 'Lazy.nvim Error',
      timeout = 10000, -- 0 means it won't disappear automatically
    })
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- NOTE: Use `opts = {}` to force a plugin to be loaded.
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      diff_opts = {
        vertical = true,
      },
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: In the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>w', group = '[W]orkspace' },
      }
    end,
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'TelescopeResults',
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd('TelescopeParent', '\t\t.*$')
            vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
          end)
        end,
      })

      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == '.' then
          return tail
        end
        return string.format('%s\t\t%s', tail, parent)
      end
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          previewer = true,

          layout_strategy = 'vertical',
          layout_config = {
            width = 0.95,
            height = 0.85,

            horizontal = {
              preview_width = function(_, cols, _)
                if cols > 200 then
                  return math.floor(cols * 0.4)
                else
                  return math.floor(cols * 0.6)
                end
              end,
            },

            vertical = {
              -- width = 0.9,
              width = function(_, cols, _)
                if cols > 200 then
                  return 190
                else
                  return math.floor(cols * 0.9)
                end
              end,
              height = 0.95,
              preview_height = 0.5,
              mirror = true,
              prompt_position = 'top',
            },

            flex = {
              horizontal = {
                preview_width = 0.9,
              },
            },
          },

          selection_strategy = 'reset',
          sorting_strategy = 'descending',
          scroll_strategy = 'cycle',
          color_devicons = true,
          path_display = filenameFirst,
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
          jumplist = {
            path_display = function(_, path)
              return require('telescope.utils').path_tail(path)
            end,
          },
          buffers = {
            mappings = {
              i = {
                ['<C-d>'] = 'delete_buffer',
              },
            },
            sort_mru = true,
            disable_coordinates = true,
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'mason-org/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        opts = { notification = { window = { winblend = 0 } } }, -- compatibility with transparent backgrounds
      },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', function()
            vim.lsp.buf.hover { border = 'single', max_width = 70 }
          end, 'Hover Documentation')

          -- Show the signature of the function call you're currently writing arguments for.
          --  This is useful when you're not sure what arguments a function takes.
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: Signature Help' })

          -- This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.INFO] = 'I',
            [vim.diagnostic.severity.HINT] = 'H',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        gopls = {},
        -- pyright = {},
        rust_analyzer = {
          config = { cargo = { features = 'all' } },
        },
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                disable = { 'missing-fields' },
                globals = { 'vim', 'pandoc' },
              },
            },
          },
        },
      }

      -- load clangd with raw lspconfig, since we want to use the system clangd
      require('lspconfig').clangd.setup {}

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        automatic_enable = { exclude = {} }, -- list of servers to not automatically enable
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- formatting for any filetypes listed with X = true will be disabled
        -- (at least regarding the lsp_fallback)
        local disable_filetypes = { css = true, elixir = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        ['<C-b>'] = {}, -- unmap default scroll doc keys, clashes with copilot
        ['<C-f>'] = {},
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        keyword = {
          range = 'full',
        },

        menu = {
          border = 'single',
          min_width = 15,
          max_height = 25,

          draw = {
            -- columns = has_devicons and menu_columns_icon or menu_columns_no_icon,
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = { border = 'single' },
        },

        list = {
          selection = {
            preselect = true,
          },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          lua = { inherit_defaults = true, 'lazydev' },
        },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      cmdline = {
        enabled = false, -- disabled for now, breaks % expansion
        keymap = {
          preset = 'inherit',
          ['<Tab>'] = { 'show', 'accept' }, -- without this mapping, the default completion menu also opens when pressing tab, causing buggy behaviour
        },
        completion = { menu = { auto_show = true } },
      },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  -- {
  --   --dir = '/home/winterveil/src/flowxi',
  --   --name = 'flowxi',
  --   'https://github.com/wintermute-cell/flowxi',
  --   priority = 1000,
  --   init = function()
  --     vim.opt.background = 'light'
  --     vim.cmd.colorscheme 'flowxi'
  --     vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#fcf8e8' }) -- darken inactive splits slightly
  --     -- Terminal colors based on your colorscheme
  --     vim.g.terminal_color_0 = '#100F0F' -- black
  --     vim.g.terminal_color_1 = '#D14D41' -- red
  --     vim.g.terminal_color_2 = '#879A39' -- green
  --     vim.g.terminal_color_3 = '#D0A215' -- yellow
  --     vim.g.terminal_color_4 = '#4385BE' -- blue
  --     vim.g.terminal_color_5 = '#CE5D97' -- magenta
  --     vim.g.terminal_color_6 = '#3AA99F' -- cyan
  --     vim.g.terminal_color_7 = '#FFFCF0' -- white
  --     vim.g.terminal_color_8 = '#100F0F' -- bright black
  --     vim.g.terminal_color_9 = '#D14D41' -- bright red
  --     vim.g.terminal_color_10 = '#879A39' -- bright green
  --     vim.g.terminal_color_11 = '#D0A215' -- bright yellow
  --     vim.g.terminal_color_12 = '#4385BE' -- bright blue
  --     vim.g.terminal_color_13 = '#CE5D97' -- bright magenta
  --     vim.g.terminal_color_14 = '#3AA99F' -- bright cyan
  --     vim.g.terminal_color_15 = '#FFFCF0' -- bright white
  --   end,
  -- },

  {
    'wintermute-cell/nvim-colorscheme',
    priority = 1000,
    init = function()
      vim.opt.background = 'light'
      vim.cmd.colorscheme 'nvimsimplecolor'
    end,
    config = function()
      require('nvimsimplecolor').setup {
        dim_inactive_windows = true, -- dim inactive windows
      }
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  { 'tpope/vim-surround' },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup {
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = false, -- prevent mini.statusline from setting itself to follow the active buffer
      }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v(%P)'
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      --statusline.section_filename = function()
      --  return vim.fn.expand '%F'
      --end
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = {
          'ruby',
          'markdown', -- breaks gw on bulletpoints if enabled
        },
      },
      textobjects = {
        -- This module allows you to select text objects (like function bodies, parameters, etc.)
        --  using the `v` keymap. For example, `vaf` will select the entire function body,
        --  and `vip` will select the inner parameter.
        enable = true,
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'outer function' },
            ['if'] = { query = '@function.inner', desc = 'inner function' },
            ['ac'] = { query = '@class.outer', desc = 'outer class' },
            ['ic'] = { query = '@class.inner', desc = 'inner class' },
            ['aP'] = { query = '@parameter.outer', desc = 'outer parameter' },
            ['iP'] = { query = '@parameter.inner', desc = 'inner parameter' },
            ['aB'] = { query = '@block.outer', desc = 'outer block' },
            ['iB'] = { query = '@block.inner', desc = 'inner block' },
            ['aS'] = { query = '@statement.outer', desc = 'outer statement' },
            ['iS'] = { query = '@statement.inner', desc = 'inner statement' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>cs'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>cS'] = '@parameter.inner',
          },
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },

  -- lockfile = os.getenv 'HOME' .. '/dotfiles/nvim/lazy-lock.json',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
