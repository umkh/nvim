-- plugins/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },           -- Qo'shilgan qatorlar uchun
        change = { text = "│" },        -- O'zgartirilgan qatorlar uchun
        delete = { text = "_" },        -- O'chirilgan qatorlar uchun
        topdelete = { text = "‾" },     -- Faylning boshida o'chirilgan qatorlar
        changedelete = { text = "~" },  -- O'zgartirilgan va o'chirilgan qatorlar
        untracked = { text = "┆" },     -- Kuzatilmagan fayllar
      },
      -- Git statusini gutterda ko'rsatish
      signcolumn = true,
      -- Hunk navigatsiyasi keymaplari
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        
        -- Keymaplarni o'rnatish
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Next Git hunk" })
        
        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Previous Git hunk" })
        
        -- Hunk operatsiyalari uchun keymaplar
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
      end,
      -- Gitdan ma'lumotlarni yangilash vaqti (ms)
      watch_gitdir = {
        interval = 1000,
      },
      current_line_blame = false, -- Hozirgi qatorda blame ko'rsatmaslik
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
      },
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })
  end,
}
