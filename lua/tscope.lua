require('telescope').setup{}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-s>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-g>', builtin.git_status, { desc = 'Telescope git status' })
vim.keymap.set('n', '<C-j>', builtin.jumplist, { desc = 'Telescope document symbols' })
