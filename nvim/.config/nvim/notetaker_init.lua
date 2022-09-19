--|################################################################
--|   _   _  ____ _______ ______ _______       _  ________ _____
--|  | \ | |/ __ |__   __|  ____|__   __|/\   | |/ |  ____|  __ \
--|  |  \| | |  | | | |  | |__     | |  /  \  | ' /| |__  | |__) |
--|  |   ` | |  | | | |  |  __|    | | / /\ \ |  < |  __| |  _  /
--|  | |\  | |__| | | |  | |____   | |/ ____ \| | \| |____| | \ \
--|  |_| \_|\____/  |_|  |______|  |_/_/    \_|_|\_|______|_|  \_\
--|
--|################################################################

local working_dir = '$HOME/notes'
os.execute("mkdir " .. working_dir)
vim.cmd([[ cd ]] .. working_dir)

require 'notetaker.options'
require 'notetaker.keymaps'
require 'notetaker.plugins'
require 'notetaker.completion'
require 'notetaker.lsp'
require 'notetaker.telescope'
require 'notetaker.treesitter'
require 'notetaker.telekasten'
require 'notetaker.markdown'
require 'shared.theme'
