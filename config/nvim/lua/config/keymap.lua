vim.g.mapleader = " "

-- Helix
vim.keymap.set("", "ge", "G")
vim.keymap.set("", "gh", "0")
vim.keymap.set("", "gl", "$")
vim.keymap.set("", "gs", "^")

-- better indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Windows
vim.keymap.set("", "<leader>ws", "<C-w>s", { desc = "Split Window Horizontally" })
vim.keymap.set("", "<leader>wv", "<C-w>v", { desc = "Split Window Vertically" })
vim.keymap.set("", "<leader>wh", "<C-w>h", { desc = "Move to Left Window" })
vim.keymap.set("", "<leader>wj", "<C-w>j", { desc = "Move to Lower Window" })
vim.keymap.set("", "<leader>wk", "<C-w>k", { desc = "Move to Upper Window" })
vim.keymap.set("", "<leader>wl", "<C-w>l", { desc = "Move to Right Window" })
vim.keymap.set("", "<leader>wq", "<C-w>q", { desc = "Quit Window" })
vim.keymap.set("", "<leader>wn", "<C-w>n", { desc = "New Window" })
vim.keymap.set("", "<leader>wo", "<C-w>o", { desc = "Close Other Windows" })
vim.keymap.set("", "<leader>wp", "<C-w>p", { desc = "Previous Window" })
vim.keymap.set("", "<leader>w=", "<C-w>=", { desc = "Equalize Window Size" })
vim.keymap.set("", "<leader>ww", "<C-w>w", { desc = "Move to Next Window" })
vim.keymap.set("", "<leader>wH", "<C-w>H", { desc = "Move Window to Left" })
vim.keymap.set("", "<leader>wJ", "<C-w>J", { desc = "Move Window to Bottom" })
vim.keymap.set("", "<leader>wK", "<C-w>K", { desc = "Move Window to Top" })
vim.keymap.set("", "<leader>wL", "<C-w>L", { desc = "Move Window to Right" })

-- CMD key
vim.keymap.set({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
-- TODO: comment with cmd + /

