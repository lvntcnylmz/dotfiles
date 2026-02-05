return {
    'stevearc/aerial.nvim',
    lazy = "LazyFile",
    config = function()
        require("aerial").setup({
            width = 40,
            min_width = 40,
        })
    end,
    keys = {
        { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
    -- enabled = false,
}
