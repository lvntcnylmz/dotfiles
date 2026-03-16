return {
  "nvim-lualine/lualine.nvim",
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
        lualine_a = {
          { "mode", icon = { "" }, color = { gui = "bold" } },
        },

        lualine_c = {
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

        lualine_b = {
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 4,
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40,
            icon_only = true,
            padding = { left = 1, right = 0 },
            -- color = { bg = "#24283b", gui = "bold" },
          },
        },

        lualine_x = {
          Snacks.profiler.status(),

          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Constant") }
            end,
          },

          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = function()
              return { fg = Snacks.util.color("Debug") }
            end,
          },

          {
            function()
              local msg = "No Active Lsp"
              local buf_ft = vim.bo.filetype
              local clients = vim.lsp.get_clients({ bufnr = 0 })

              if not clients or vim.tbl_isempty(clients) then
                return " " .. msg
              end

              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.tbl_contains(filetypes, buf_ft) then
                  return "  " .. client.name
                end
              end

              return msg
            end,
            -- icon = " ",
            -- color = { bg = "#24283b", fg = "#e0af68", gui = "bold" },
          },

          {
            "fileformat",
            icons_enabled = false,
            -- color = { bg = "#24283b" }
          },
          {
            "encoding",
            -- color = { bg = "#24283b", gui = "bold" }
          },
        },

        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 }, color = { gui = "bold" } },
          { "location", padding = { left = 0, right = 1 }, color = { gui = "bold" } },
        },

        lualine_z = {
          {
            function()
              return os.date("%R ") .. " "
            end,
            color = { gui = "bold" },
          },
        },
      },

      extensions = { "lazy" },
    }
  end,
}
