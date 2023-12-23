return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	lazy = false,
    opts = {
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
        },
    }
}
