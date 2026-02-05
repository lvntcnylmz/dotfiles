return {
	"folke/todo-comments.nvim",
	event = "FileType",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous todo comment",
		},
		{ "<leader>st", "<cmd>TodoQuickFix<cr>", desc = "Todo List" },
		{ "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
	},
}
