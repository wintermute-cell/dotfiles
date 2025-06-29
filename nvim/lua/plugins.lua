return {

  -- [[ Optimization ]] --
  -------------------
  { -- Automatically disables some features when opening a large file
    'LunarVim/bigfile.nvim',
    opts = {
      -- size of the file in MiB, plugin rounds file sizes to the closest MiB
      filesize = 2,
    },
  },

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
        cursor_follows_swapped_bufs = true,
        multiplexer_integration = false,
      }

      local function resize_mode_off()
        -- Unmap the resize mode keys
        vim.keymap.del('n', 'h')
        vim.keymap.del('n', 'j')
        vim.keymap.del('n', 'k')
        vim.keymap.del('n', 'l')
        vim.keymap.del('n', '<C-w><C-h>')
        vim.keymap.del('n', '<C-w><C-j>')
        vim.keymap.del('n', '<C-w><C-k>')
        vim.keymap.del('n', '<C-w><C-l>')
        vim.keymap.del('n', '<Esc>')
      end

      local function resize_mode_on()
        -- Resize splits
        vim.keymap.set('n', 'h', ss.resize_left, { desc = 'resize split leftward' })
        vim.keymap.set('n', 'j', ss.resize_down, { desc = 'resize split downward' })
        vim.keymap.set('n', 'k', ss.resize_up, { desc = 'resize split upward' })
        vim.keymap.set('n', 'l', ss.resize_right, { desc = 'resize split rightward' })
        -- Swapping splits
        vim.keymap.set('n', '<C-w><C-h>', ss.swap_buf_left, { desc = 'swap with left split' })
        vim.keymap.set('n', '<C-w><C-j>', ss.swap_buf_down, { desc = 'swap with split below' })
        vim.keymap.set('n', '<C-w><C-k>', ss.swap_buf_up, { desc = 'swap with split above' })
        vim.keymap.set('n', '<C-w><C-l>', ss.swap_buf_right, { desc = 'swap with right split' })

        -- Make ESC key exit resize mode
        vim.keymap.set('n', '<Esc>', function()
          vim.g.resize_mode = false
          resize_mode_off()
          vim.notify('Resize mode is now OFF', vim.log.levels.INFO, { title = 'Smart Splits' })
        end, { desc = 'Exit resize mode' })
      end

      vim.g.resize_mode = false
      vim.keymap.set('n', '<C-w>r', function()
        vim.g.resize_mode = not vim.g.resize_mode
        vim.notify('Resize mode is now ' .. (vim.g.resize_mode and 'ON' or 'OFF'), vim.log.levels.INFO, { title = 'Smart Splits' })
        if vim.g.resize_mode then
          resize_mode_on()
        else
          resize_mode_off()
        end
      end, { desc = 'Toggle resize mode' })

      -- Moving between splits
      vim.keymap.set('n', '<C-w>h', ss.move_cursor_left, { desc = 'move to left split' })
      vim.keymap.set('n', '<C-w>j', ss.move_cursor_down, { desc = 'move to split below' })
      vim.keymap.set('n', '<C-w>k', ss.move_cursor_up, { desc = 'move to split above' })
      vim.keymap.set('n', '<C-w>l', ss.move_cursor_right, { desc = 'move to right split' })
    end,
  },

  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   lazy = false,
  --   version = '*', -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     -- add any opts here
  --     provider = 'openai',
  --     auto_suggetions_provider = 'copilot',
  --     openai = {
  --       endpoint = 'https://openrouter.ai/api/v1',
  --       model = 'anthropic/claude-3.7-sonnet',
  --       timeout = 30000, -- Timeout in milliseconds
  --       temperature = 0.2,
  --       max_tokens = 4096,
  --       ['api_key_name'] = 'OPENROUTER_API_KEY',
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = 'make',
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     --- The below dependencies are optional,
  --     'echasnovski/mini.pick', -- for file_selector provider mini.pick
  --     'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
  --     'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
  --     'ibhagwan/fzf-lua', -- for file_selector provider fzf
  --     'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
  --     'zbirenbaum/copilot.lua', -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { 'Avante' },
  --       },
  --       ft = { 'Avante' },
  --     },
  --   },
  -- },

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
}
