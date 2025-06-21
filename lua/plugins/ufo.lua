-- plugins/ufo.lua
return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "BufReadPost",
  config = function()
    -- UFO uchun asosiy tugmalarni o'rnatish
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with" })
    vim.keymap.set("n", "zp", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek folded lines" })

    -- Qo'shimcha tugma: K tugmasi hoverlash yoki fold preview
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        -- Agar fold bo'lmasa, standart K funksiyasini ishlatish
        vim.lsp.buf.hover()
      end
    end, { desc = "Hover or peek fold" })

    -- Foldlarni provider orqali aniqlash
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ("  %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- Agar truncate qilingan bo'lsa, to'xtatamiz
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end

      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end

    require("ufo").setup({
      open_fold_hl_timeout = 150,
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = handler,
      enable_get_fold_virt_text = true,
      preview = {
        win_config = {
          border = "rounded",
          winhighlight = "Normal:Normal",
          winblend = 0,
        },
      },
    })

    -- Ko'pgina tillar uchun fold darajasini 99 ga o'rnatish
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
}
