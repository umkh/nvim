require('bufferline').setup({
    options = {
        themable = true,
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil,         -- can be a string | function, | false see "Mouse actions"
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        diagnostics = "nvim_lsp",
        numbers = "ordinal",
        diagnostics_update_on_event = true,
        color_icons = true,
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
    },
})

local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set('n', '<C-[>', ':BufferLineCyclePrev<CR>', opts)
vim.keymap.set('n', '<C-]>', ':BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<C-c>', ':BufferLineCloseOthers<CR>', opts)
