return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    theme = "dragon",
    overrides = function(colors)
      return {
        Normal = { bg = "#000000" },
        NormalFloat = { bg = "#000000" },
        FloatBorder = { bg = "#000000" },
        SignColumn = { bg = "#000000" },
        LineNr = { bg = "#000000" },
        CursorLine = { bg = "#000000" },
        CursorLineNr = { bg = "#000000" },
      }
    end,
  },
}
