-- plugins/dap.lua
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui", -- Debug UI
      "leoluz/nvim-dap-go", -- Go adapter
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI konfiguratsiyasi
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- Oynada navigatsiya
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40, -- 40 ustun
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25, -- Ekranning 25%
            position = "bottom",
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = { 
          max_type_length = nil, -- Can be integer or nil.
        }
      })

      -- Go debugger sozlamalari
      require("dap-go").setup({
        -- delve konfiguratsiyasi
        dap_configurations = {
          {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}"
          },
          {
            type = "go",
            name = "Debug test", -- Testlarni debug qilish
            request = "launch",
            mode = "test",
            program = "${file}"
          },
          -- Websocketlar orqali ulanish
          {
            type = "go",
            name = "Attach to process",
            mode = "local",
            request = "attach",
            processId = require('dap.utils').pick_process,
          },
        },
        -- delve options
        delve = {
          -- delve executable yoki delve binary yo'li
          path = "dlv", -- Go bilan o'rnatiladi
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
          build_flags = "",
        },
      })

      -- Eventlar
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open() -- Debug boshlanishidan so'ng UI ni ochish
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close() -- Debug tugashidan avval UI ni yopish
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close() -- Debug dasturdan chiqish oldidan UI ni yopish
      end

      -- Keymaplar
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug Continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug Step Over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug Step Out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug Last" })
      vim.keymap.set("n", "<leader>dt", function() 
        dap.terminate()
        dapui.close()
      end, { desc = "Debug Terminate" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  }
}
