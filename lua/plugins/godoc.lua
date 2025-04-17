-- plugins/godoc.lua - Go documentation browser

return {
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- optional
      { "folke/snacks.nvim" }, -- optional
      { "echasnovski/mini.pick" }, -- optional
      { "ibhagwan/fzf-lua" }, -- optional
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = { "go" },
        },
      },
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "GoDoc" }, -- optional
    config = function()
      local godoc = require("godoc")
      
      godoc.setup({
        adapters = {
          -- for details, see lua/godoc/adapters/go.lua
          {
            name = "go",
            opts = {
              command = "GoDoc", -- the vim command to invoke Go documentation
              get_syntax_info = function()
                return {
                  filetype = "godoc", -- filetype for the buffer
                  language = "go", -- tree-sitter parser, for syntax highlighting
                }
              end,
            },
          },
        },
        window = {
          type = "split", -- split | vsplit
        },
        picker = {
          type = "native", -- native (vim.ui.select) | telescope | snacks | mini | fzf_lua
          
          -- see respective picker in lua/godoc/pickers for available options
          native = {},
          telescope = {},
          snacks = {},
          mini = {},
          fzf_lua = {},
        },
      })
    end,
  }
}
