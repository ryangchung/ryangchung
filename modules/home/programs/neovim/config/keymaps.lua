-- mapleader
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "<leader>[", ":bn<cr>")
vim.keymap.set("n", "<leader>]", ":bp<cr>")
vim.keymap.set("n", "<leader>d", ":bd<cr>")

-- clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
