return {

  -- [[ Visuals ]] --
  -------------------
  { -- Adds colorization to hex codes like #ff0000
    'NvChad/nvim-colorizer.lua',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        names = false,
        mode = 'background',
      },
      init = function()
        vim.opt.termguicolors = true
      end,
    },
  },

  -- {
  --   'marcussimonsen/let-it-snow.nvim',
  --   cmd = 'LetItSnow', -- Wait with loading until command is run
  --   opts = {
  --     delay = 110,
  --   },
  -- },

  --{ 'xiyaowong/transparent.nvim' },

  -- {
  --   'vim-scripts/vis',
  -- },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    enabled = false,
    main = 'ibl',
    opts = {},
  },

  -- [[ Features ]] --
  --------------------
  { 'mbbill/undotree' },

  {
    'mrjones2014/smart-splits.nvim',
    event = 'VeryLazy', -- this plugin has a pretty slow startup time...
    config = function()
      local ss = require 'smart-splits'
      ss.setup {
        default_amount = 5,
      }
      -- Resize splits
      vim.keymap.set('n', '<C-w><C-h>', require('smart-splits').resize_left, { desc = 'resize split leftward' })
      vim.keymap.set('n', '<C-w><C-j>', require('smart-splits').resize_down, { desc = 'resize split downward' })
      vim.keymap.set('n', '<C-w><C-k>', require('smart-splits').resize_up, { desc = 'resize split upward' })
      vim.keymap.set('n', '<C-w><C-l>', require('smart-splits').resize_right, { desc = 'resize split rightward' })

      -- Moving between splits
      vim.keymap.set('n', '<C-w>h', require('smart-splits').move_cursor_left, { desc = 'move to left split' })
      vim.keymap.set('n', '<C-w>j', require('smart-splits').move_cursor_down, { desc = 'move to split below' })
      vim.keymap.set('n', '<C-w>k', require('smart-splits').move_cursor_up, { desc = 'move to split above' })
      vim.keymap.set('n', '<C-w>l', require('smart-splits').move_cursor_right, { desc = 'move to right split' })

      -- Swapping splits
      vim.keymap.set('n', '<C-w><A-h>', require('smart-splits').swap_buf_left, { desc = 'swap with left split' })
      vim.keymap.set('n', '<C-w><A-j>', require('smart-splits').swap_buf_down, { desc = 'swap with split below' })
      vim.keymap.set('n', '<C-w><A-k>', require('smart-splits').swap_buf_up, { desc = 'swap with split above' })
      vim.keymap.set('n', '<C-w><A-l>', require('smart-splits').swap_buf_right, { desc = 'swap with right split' })
    end,
  },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = '*', -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      provider = 'openai',
      auto_suggetions_provider = 'copilot',
      openai = {
        endpoint = 'https://api.deepseek.com/v1',
        model = 'deepseek-chat',
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
        ['api_key_name'] = 'DEEPSEEK_API_KEY',
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'Avante' },
        },
        ft = { 'Avante' },
      },
    },
  },

  {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<C-f>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    },
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'harpoon: append to list' })

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'harpoon: toggle quick menu' })

      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-k>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-l>', function()
        harpoon:list():select(3)
      end)
      -- NOTE: Can't map semicolon!
      -- vim.keymap.set('n', '<C-;>', function()
      --   harpoon:list():select(4)
      -- end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<S-H>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<S-L>', function()
        harpoon:list():next()
      end)
    end,
  },

  {
    'wintermute-cell/gitignore.nvim',
    config = function()
      require 'gitignore'
    end,
  },

  --   {
  --     dir = '/home/winterveil/lab/lir.nvim',
  --     config = function()
  --       local lir = require 'lir'
  --       local actions = require 'lir.actions'
  --       local mark_actions = require 'lir.mark.actions'
  --       local clipboard_actions = require 'lir.clipboard.actions'
  --
  --       local function open_with_xdg(f)
  --         local f = lir.get_context():current().fullpath
  --         vim.fn.system("xdg-open '" .. string.gsub(f, '([\'"\\])', '\\%1') .. "'")
  --       end
  --
  --       local function reverse_sort()
  --         local f = lir.get_context().files
  --         if vim.g.lir_is_reverse then
  --           vim.g.lir_is_reverse = not vim.g.lir_is_reverse
  --           table.sort(f, function(a, b)
  --             return a.name < b.name
  --           end)
  --         else
  --           vim.g.lir_is_reverse = true
  --           table.sort(f, function(a, b)
  --             return a.name > b.name
  --           end)
  --         end
  --         lir.get_context().files = f
  --         actions.reload()
  --       end
  --
  --       lir.setup {
  --         show_hidden_files = false,
  --         header = [[===============================================================================
  --   Quick Help:
  --     <CR>: open          <Del>: delete      <C-h>: toggle hidden
  --     <C-l>: refresh      -: up              a: toggle hidden
  --     c: cd               d: mkdir           D: delete
  --     gf: open            gh: toggle hidden  R: rename
  --     s: sort             t: tabedit         v: vsplit
  --     x: open with xdg    %: new file        m: mark
  --     M: unmark           <Space>: toggle mark  y: yank path
  -- ===============================================================================]],
  --         disable_highlight = true,
  --         show_navigation = true,
  --         devicons = { enable = false },
  --         mappings = {
  --           ['<CR>'] = actions.edit, -- Enter to open a file/directory
  --           ['<Del>'] = actions.delete, -- Del to delete a file/directory
  --           ['<C-h>'] = actions.toggle_show_hidden, -- Ctrl-H to toggle hidden files
  --           ['<C-l>'] = actions.reload, -- Ctrl-L to refresh the directory
  --           ['-'] = actions.up, -- '-' to go up one directory
  --           ['a'] = actions.toggle_show_hidden, -- 'a' to toggle normal/hidden file visibility
  --           ['c'] = actions.cd, -- 'c' to change directory
  --           ['d'] = actions.mkdir, -- 'd' to create a directory
  --           ['D'] = actions.delete, -- 'D' to delete the file/directory
  --           ['gf'] = actions.edit, -- 'gf' to open the file
  --           ['gh'] = actions.toggle_show_hidden, -- 'gh' to toggle hidden files visibility
  --           ['R'] = actions.rename, -- 'R' to rename a file/directory
  --           ['s'] = reverse_sort, -- 's' to refresh (sort equivalent)
  --           ['t'] = actions.tabedit, -- 't' to open a file in a new tab
  --           ['v'] = actions.vsplit, -- 'v' to open a file in a vertical split
  --           ['x'] = open_with_xdg, -- 'x' to open the file under cursor
  --           ['%'] = actions.newfile, -- '%' to create a new file
  --           ['m'] = mark_actions.mark, -- 'm' to mark a file
  --           ['M'] = mark_actions.unmark, -- 'M' to unmark files
  --           ['<Space>'] = mark_actions.toggle, -- Space to toggle marks
  --           ['y'] = actions.yank_path, -- 'y' to yank the file path
  --         },
  --         -- on_init = function()
  --         --   -- prepend the current buffer with a header like `hello world`
  --         --   vim.api.nvim_buf_set_option(0, 'modifiable', true)
  --         --   vim.api.nvim_buf_set_lines(0, 0, 0, false, { 'hello world' })
  --         --   vim.api.nvim_buf_set_option(0, 'modifiable', false)
  --         -- end,
  --       }
  --     end,
  --   },

  -- [[ Languages ]] --
  ---------------------
  {
    'lervag/vimtex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_quickfix_ignore_filters = { 'Overfull', 'Underfull', 'Warning' }
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_mappings_prefix = '<localleader>v'
    end,
  },

  {
    'dag/vim-fish',
    ft = 'fish',
    config = function()
      vim.cmd [[
        autocmd FileType fish compiler fish
        autocmd FileType fish setlocal textwidth=79
        autocmd FileType fish setlocal foldmethod=expr
      ]]
    end,
  },

  -- {
  --   'Badhi/nvim-treesitter-cpp-tools',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   -- Optional: Configuration
  --   opts = function()
  --     local options = {
  --       preview = {
  --         quit = 'q', -- optional keymapping for quit preview
  --         accept = '<tab>', -- optional keymapping for accept preview
  --       },
  --       header_extension = 'h', -- optional
  --       source_extension = 'cpp', -- optional
  --       custom_define_class_function_commands = { -- optional
  --         TSCppImplWrite = {
  --           output_handle = require('nt-cpp-tools.output_handlers').get_add_to_cpp(),
  --         },
  --         --[[
  --               <your impl function custom command name> = {
  --                   output_handle = function (str, context)
  --                       -- string contains the class implementation
  --                       -- do whatever you want to do with it
  --                   end
  --               }
  --               ]]
  --       },
  --     }
  --     return options
  --   end,
  --   -- End configuration
  --   config = true,
  -- },
}
