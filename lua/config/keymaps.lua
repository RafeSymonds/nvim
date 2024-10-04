-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("telescope").load_extension("file_browser")

-- Define the custom mapping
vim.keymap.set("n", "<leader><space>", ":Telescope file_browser path=%:p:h=%:p:h<cr>", { desc = "Browse files" })
vim.keymap.set("n", "<C-p>", '"_viwp', { desc = "Paste and delete", noremap = true, silent = true })
-- vim.keymap.set("n", "<C-0>", '"_ddp', { desc = "Paste and delete", noremap = true, silent = true })
