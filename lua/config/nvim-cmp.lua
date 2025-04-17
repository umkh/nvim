-- nvim-cmp.lua - Autocompletion configuration for Neovim

--------------------------------------------------
-- Helper functions
--------------------------------------------------

-- Check if there's a word before the cursor position
local function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--------------------------------------------------
-- Load modules
--------------------------------------------------
local luasnip = require("luasnip")
local cmp = require("cmp")

--------------------------------------------------
-- Autocompletion configuration
--------------------------------------------------
cmp.setup({
    -- Snippets configuration
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For LuaSnip users
        end,
    },

    -- Keyboard mapping configuration
    mapping = cmp.mapping.preset.insert({
        -- Scroll documentation
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        
        -- Select items in menu
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        
        -- Confirm selected item
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Tab navigation
        -- Source: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }), -- i - insert mode; s - select mode
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    -- Menu appearance configuration
    -- Source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
    formatting = {
        -- Order from left to right
        -- abbr: abbreviation of word, shown in menu
        -- menu: additional text, shown after abbr
        fields = { 'abbr', 'menu' },

        -- Customize menu appearance
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
            })[entry.source.name]
            return vim_item
        end,
    },

    -- Source priority
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- LSP server
        { name = 'luasnip' },   -- LuaSnip snippets
        { name = 'buffer' },    -- Words from open buffers
        { name = 'path' },      -- Filesystem paths
    })
})
