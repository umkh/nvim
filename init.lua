-- init.lua - Main Neovim configuration file

-- Load core configurations first
require('config.options')     -- Basic Neovim options
require('config.keymaps')     -- Global keymaps

-- Initialize plugin manager (this loads all plugins inside plugins/ folder)
require('config.lazy')

-- Load LuaSnip snippets
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})

-- Note: All other plugins are now automatically loaded through Lazy.nvim
-- from the plugins/ directory. Individual plugin configurations are in:
-- - lua/plugins/*.lua - Plugin declarations and configurations
-- - lua/config/*.lua - Core configurations and complex plugin setups
