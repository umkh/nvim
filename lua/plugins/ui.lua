-- plugins/ui.lua - UI elements

return {
  -- Web devicons (still needed by multiple plugins)
  { "nvim-tree/nvim-web-devicons" },
  
  -- Notifications and UI improvements
  {
    "folke/noice.nvim",
    opts = {
      notify = {
        position = {
          -- vim.opt.lines:get() - 2 for bottom center
          row = vim.opt.lines:get() - 2,  -- 2 rows from bottom
          col = -2,  -- 2 columns from right
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        enabled = true,
        view = "notify",
      },
      lsp = {
        progress = {
          enabled = true,
          view = "mini",
        },
      },
      messages = {
        enabled = true,
        view = "notify",
        timeout = 2000,
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    },
  },
  
  -- Markdown rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}
