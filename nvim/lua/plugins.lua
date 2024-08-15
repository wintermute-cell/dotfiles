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
      vim.keymap.set('n', '<C-;>', function()
        harpoon:list():select(4)
      end)

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
    'nvim-neotest/neotest',
    dependencies = {
      'thenbe/neotest-playwright',
      dependencies = 'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require('neotest-playwright').adapter {
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>tt', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = 'neotest: Run File' })
      vim.keymap.set('n', '<leader>tT', function()
        require('neotest').run.run(vim.loop.cwd())
      end, { desc = 'neotest: Run All Test Files' })
      vim.keymap.set('n', '<leader>tr', function()
        require('neotest').run.run()
      end, { desc = 'neotest: Run Nearest' })
      vim.keymap.set('n', '<leader>ts', function()
        require('neotest').summary.toggle()
      end, { desc = 'neotest: Toggle Summary' })
      vim.keymap.set('n', '<leader>to', function()
        require('neotest').output.open { enter = true, auto_close = true }
      end, { desc = 'neotest: Show Output' })
      vim.keymap.set('n', '<leader>tO', function()
        require('neotest').output_panel.toggle()
      end, { desc = 'neotest: Toggle Output Panel' })
      vim.keymap.set('n', '<leader>tS', function()
        require('neotest').run.stop()
      end, { desc = 'neotest: Stop' })
    end,
  },

  {
    'wintermute-cell/gitignore.nvim',
    config = function()
      require 'gitignore'
    end,
  },

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
