local config = function()
	require("tokyonight").setup({
		style = "night",
		lualine_bold = true,
		hide_inactive_statusline = true,
		transparent = true, -- Enable this to disable setting the background color
		styles = {
			keywords = { italic = false },
		},
	})
	vim.cmd.colorscheme("tokyonight")
end

return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = config,
}
