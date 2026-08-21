-- lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local icons = {
      diagnostics = { Error = " ", Warn = " ", Info = " ", Hint = " " },
      git = { added = " ", modified = " ", removed = " " },
    }

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "snacks_dashboard" } },
      },

      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
            separator = { left = "" },
            right_padding = 2,
          },
        },

        lualine_b = {
          {
            "branch",
            icon = "",
          },
          {
            "diff",
            symbols = icons.git,
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },

        lualine_c = {
          {
            "diagnostics",
            symbols = icons.diagnostics,
          },
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            path = 1, -- relative path
            symbols = {
              modified = "  ",
              readonly = "",
              unnamed = "",
              newfile = "",
            },
          },
        },

        lualine_x = {
          {
            function()
              local ok, noice = pcall(require, "noice")
              if ok and noice.api.status.command.has() then
                return noice.api.status.command.get()
              end
              return ""
            end,
            cond = function()
              local ok, noice = pcall(require, "noice")
              return ok and noice.api.status.command.has()
            end,
          },
          {
            function()
              local ok, noice = pcall(require, "noice")
              if ok and noice.api.status.mode.has() then
                return noice.api.status.mode.get()
              end
              return ""
            end,
            cond = function()
              local ok, noice = pcall(require, "noice")
              return ok and noice.api.status.mode.has()
            end,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return ""
              end
              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end
              return " " .. table.concat(names, ", ")
            end,
            color = { gui = "italic" },
          },
        },

        lualine_y = {
          { "progress", separator = "", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },

        lualine_z = {
          {
            function()
              return " " .. os.date("%R")
            end,
            separator = { right = "" },
            left_padding = 2,
          },
        },
      },

      extensions = { "neo-tree", "lazy", "trouble" },
    }
  end,
}
