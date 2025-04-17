-- plugins/lsp.lua - LSP and completion setup

return {
  -- LSP manager
  {
    "williamboman/mason.nvim",
    config = function()
      -- Mason configuration happens in config/lsp.lua
    end,
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      require("config.lsp").setup()
    end,
  },

  -- Vscode-like pictograms
  {
    "onsails/lspkind.nvim",
    event = { "VimEnter" },
  },

  -- Auto-completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
      "hrsh7th/cmp-buffer",   -- buffer auto-completion
      "hrsh7th/cmp-path",     -- path auto-completion
      "hrsh7th/cmp-cmdline",  -- cmdline auto-completion
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },

  -- Code snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    keys = {
      {
        "<C-l>",  -- Ctrl+l to avoid conflict with LSP
        function()
          local ls = require("luasnip")
          if ls.expandable() then
            ls.expand()
          end
        end,
        mode = "i",
      },
    },
    config = function()
      local ls = require("luasnip")
      
      ls.add_snippets("go", {
        ls.snippet("ie;", {  -- ie; to avoid conflict with LSP
          ls.text_node({"if err != nil {",
            "\treturn err",
            "}"})
        }),
        
        ls.snippet("iee;", { -- iee; with semicolon
          ls.text_node({"if err != nil {",
            "\treturn nil, err",
            "}"})
        }),
      })
    end,
  },
}
