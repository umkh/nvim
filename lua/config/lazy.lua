-- config/lazy.lua - Lazy.nvim bootstrap and setup

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Load plugins from the plugins directory
  { import = "plugins" },
  -- Plugin spec options
  spec = {
    { import = "plugins" },
  },
  -- Default plugin configuration
  defaults = {
    lazy = false,
    version = false,
  },
  -- Installation settings
  install = { colorscheme = { "catppuccin", "kanagawa" } },
  -- UI settings
  ui = {
    border = "rounded",
  },
  -- Performance settings
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
