local keymap = vim.keymap

-- General keymap
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>qq", ":q!<CR>") -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>") -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor
keymap.set("n", "<C-a>", "gg V G", { desc = "Select all" })

-- Diretory Navigation
keymap.set("n", "<leader>fe", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true, silent = true })

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })
keymap.set("n", "<leader>sm", ":MaximazerToggle<CR>", { desc = "Toogle minimize" })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Indenting
keymap.set("v", "<", "<gv", { desc = "indenting" })
keymap.set("v", ">", ">gv", { desc = "indenting" })

-- Comments
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { desc = "comment on normal mode", noremap = false })
vim.api.nvim_set_keymap("v", "<C-/>", "gcc", { desc = "comment on visual mode", noremap = false })

-- lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
