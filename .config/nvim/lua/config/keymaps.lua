local keymap = vim.keymap

local opts = { noremap = true, silent = true } 

-- directory navigation
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", opts) 
keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", opts)

-- pane navigation 
keymap.set("n", "<C-h>", "<C-w>h", opts) -- navigate left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- navigate down 
keymap.set("n", "<C-k>", "<C-w>k", opts) -- navigate up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- navigate right

-- window management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- split vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- split horizontally
keymap.set("n", "<leader>sm", ":MaximizeToggle<CR>", opts) -- toggle minimize

-- indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- comments
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-/>", "gcc", { noremap = false })
