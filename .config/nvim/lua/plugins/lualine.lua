return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = require("lazyvim.config").icons

    vim.o.laststatus = vim.g.lualine_laststatus

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { { "mode", icon = { "" }, color = { gui = "bold" } } },
        lualine_b = {
          { "branch", color = { gui = "bold" } },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
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
            color = { gui = "bold" },
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
            color = { gui = "bold" },
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, padding = { left = 1, right = 0 }, color = { bg = "#24283b", gui = "bold" } },
          { "filename", padding = { left = 0, right = 1 }, color = { bg = "#24283b", gui = "bold" } },
        },
        lualine_x = {
          Snacks.profiler.status(),
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --   color = function() return { fg = Snacks.util.color("Statement") } end,
          -- },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          {
            function()
              local msg = "No Active Lsp"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            icon = " ",
            color = { bg = "#24283b", fg = "#e0af68", gui = "bold" },
          },
          { "fileformat", icons_enabled = false, color = { bg = "#24283b" } },
          { "encoding", color = { bg = "#24283b", gui = "bold" } },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 }, color = { gui = "bold" } },
          { "location", padding = { left = 0, right = 1 }, color = { gui = "bold" } },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%R")
            end,
            color = { gui = "bold" },
          },
        },
      },
      extensions = { "lazy" },
    }
  end,
}
