local config = function()
    require("toggleterm").setup()
end

local keys = {
    vim.keymap.set("n", "<leader>ot", ":ToggleTerm size=20 border=curved direction=float<CR>", { desc = "Toggle terminal" })
}

return {
    'akinsho/toggleterm.nvim',
    version = "*",
    lazy = false,
    config = config,
    keys = keys,
}
