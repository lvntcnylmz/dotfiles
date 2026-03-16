-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>E", function()
  Snacks.explorer({
    cwd = vim.fn.expand("%:p:h"),
  })
end, { desc = "Explorer (file dir)" })
