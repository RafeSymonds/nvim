-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereby
vim.g.lazyvim_python_lsp = "pyright"

vim.g.lazyvim_python_ruff = "ruff"

vim.g.autoformat = true

vim.o.tabstop = 4

vim.o.expandtab = true

vim.o.softtabstop = 4

vim.o.shiftwidth = 4

vim.o.title = true

vim.o.titlestring = "%{fnamemodify(getcwd(), ':t')}"

vim.opt.clipboard = "unnamedplus"
