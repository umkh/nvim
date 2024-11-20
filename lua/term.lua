require("toggleterm").setup{}

vim.keymap.set("n", "<space>t", ":ToggleTerm size=50 dir=%:p:h<CR>") -- open terminal in the directory of the file

