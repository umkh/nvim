-- plugins/terminal.lua - Terminal configuration

return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      local status_ok, toggleterm = pcall(require, "toggleterm")
      if not status_ok then
        return
      end

      toggleterm.setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Define terminal keymaps
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          local opts = {noremap = true}
          vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
          vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
          vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
          vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
          vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
          vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
        end,
      })

      -- Create lazygit terminal
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

      -- Expose lazygit toggle function globally
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- Uncomment any of these lines to set your preferred terminal mapping
      -- vim.keymap.set("n", "<space>t", ":ToggleTerm direction=float<CR>") -- open terminal in float mode
      -- vim.keymap.set("n", "<space>t", ":ToggleTerm size=60 direction=horizontal<CR>") -- open terminal horizontally
      -- vim.keymap.set("n", "<space>t", ":ToggleTerm size=50 dir=%:p:h<CR>") -- open terminal in the directory of the file
    end,
  }
}
