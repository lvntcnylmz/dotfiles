return { -- This plugin
	"Zeioth/compiler.nvim",
	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	dependencies = { "stevearc/overseer.nvim" },
	opts = {},
	config = function()
	    require("compiler").setup({})
    end,
	keys = {
		{
			"<F6>",
			"<cmd>CompilerOpen<cr>",
			{ desc = "Open Compiler", noremap = true, silent = true },
		},
		{
			"<S-F6>",
			"<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
				.. "<cmd>CompilerRedo<cr>",
			{ desc = "Stop Compiler", noremap = true, silent = true }
		},
        {
			"<S-F7>",
			"<cmd>CompilerToggleResults<cr>",
			{ desc = "Toggle Compiler Results", noremap = true, silent = true }
		},
	},
}
