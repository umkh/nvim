-- plugins/telescope.lua - Fuzzy finder configuration

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup{}

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-s>', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<C-g>', builtin.git_status, { desc = 'Telescope git status' })
      vim.keymap.set('n', '<C-j>', builtin.jumplist, { desc = 'Telescope document symbols' })
      vim.keymap.set('n', '<C-/>', function()
        require('telescope.builtin').current_buffer_fuzzy_find()
      end, { desc = 'Search in current buffer' })
    end,
  }
}
