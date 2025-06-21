-- plugins/trouble.lua
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({
      position = "bottom",
      icons = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
      },
      mode = "workspace_diagnostics",
      padding = true,
      action_keys = {
        close = "q",
        refresh = "r",
        jump = {"<cr>", "<tab>"},
      },
    })
    -- Keymaplarni o'rnatish
    vim.keymap.set("n", "<leader>xx", function()
      require("trouble").toggle("diagnostics")
    end, { desc = "Document Diagnostics" })
  end,
}
