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

  --{ 'xiyaowong/transparent.nvim' },

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
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<M-l>',
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

      harpoon:setup {}

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():append()
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
}
