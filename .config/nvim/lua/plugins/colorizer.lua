local config = function()
	require("colorizer").setup({
		filetypes = { "css", "javascript", "html" },
	})
end

return {
	"NvChad/nvim-colorizer.lua",
	config = config,
	lazy = false,
}
