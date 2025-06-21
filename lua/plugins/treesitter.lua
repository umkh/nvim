-- plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- O'rnatish uchun tillar
        ensure_installed = {
          "go", "gomod", "gosum", "gowork",
          "lua", "vim", "vimdoc",
          "bash", "json", "yaml", "markdown", "markdown_inline",
          "sql", "regex", "dockerfile",
        },
        -- Avtomatik o'rnatish
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        -- Indentatsiya
        indent = { enable = true },
        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
          },
        },
        -- Textobjects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- Funksiyalar uchun
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              -- Klasslar uchun
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              -- Shartlar uchun
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              -- Looplar uchun
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              -- Kommentariyalar uchun
              ["a/"] = "@comment.outer",
            },
          },
          -- Funksiyalar va klasslar orasida harakatlanish
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },
      })
    end,
  }
}
