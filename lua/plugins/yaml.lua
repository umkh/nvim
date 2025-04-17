-- plugins/yaml.lua - YAML files configuration

return {
  -- 1. YAML filetype for treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yaml" })
      end
    end,
  },
  -- 2. Formatting with yamlfmt
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        yaml = { "yamlfmt" },
      },
      -- Format on save
      format_on_save = {
        -- Only for yaml files
        pattern = { "*.yaml", "*.yml" },
        lsp_fallback = true,
        timeout_ms = 500,
      },
      -- YAML formatter configuration
      formatters = {
        yamlfmt = {
          -- Additional settings for yamlfmt if needed
          command = "yamlfmt",
          args = { "-" },  -- read from stdin
        },
      },
    },
  },
  -- 3. Add autocmd for formatting on save (as backup)
  {
    "nvim-lua/plenary.nvim", -- use plenary instead of LazyVim
    optional = true,
    config = function()
      -- YAML file formatting on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.yaml", "*.yml" },
        callback = function()
          -- Use conform.nvim if available
          local conform_ok, conform = pcall(require, "conform")
          if conform_ok then
            conform.format({ bufnr = 0 })
          else
            -- Otherwise use LSP formatter
            vim.lsp.buf.format({ timeout_ms = 1000 })
          end
        end,
      })
    end,
  },
}
