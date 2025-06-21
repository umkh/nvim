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

    -- 2. Formatting with yamlfmt (manual format only)
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            formatters_by_ft = {
                yaml = { "yamlfmt" },
            },
            -- Disable auto format on save
            format_on_save = false,
            -- YAML formatter configuration
            formatters = {
                yamlfmt = {
                    command = "yamlfmt",
                    args = { "-" }, -- read from stdin
                },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)

            -- Add shortcut for manual formatting
            -- <leader>f to format YAML files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "yaml", "yml" },
                callback = function()
                    vim.keymap.set("n", "<leader>f", function()
                        require("conform").format({ bufnr = 0 })
                    end, { buffer = true, desc = "Format YAML file" })
                end,
            })
        end,
    },
}

