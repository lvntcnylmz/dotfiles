-- local opts = function ()
--     require("ibl").setup({
--         exclude = {
--             filetypes = {
--               "help",
--               "alpha",
--               "dashboard",
--               "neo-tree",
--               "Trouble",
--               "trouble",
--               "lazy",
--               "mason",
--               "notify",
--               "toggleterm",
--               "lazyterm",
--             },
--         },
--     })

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "BufRead",
	opts = {},
}
