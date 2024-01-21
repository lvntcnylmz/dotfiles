local config = function()
    require("tokyonight").setup({
        style = "night",
    })
    vim.cmd("colorscheme tokyonight")
end

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = config,
}
