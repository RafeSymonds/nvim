-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
function _G.open_split_terminal_and_resize()
    vim.cmd("split | terminal")

    vim.cmd("resize -12")

    vim.cmd("startinsert")
end

require("config.keymaps")

local wk = require("which-key")

require("plugins.snippets")

-- add custom key binds
wk.add({
    {
        "<leader>t",
        ":lua open_split_terminal_and_resize()<CR>",
        desc = "Open Split Terminal",
    },
})

local format_group =
    vim.api.nvim_create_augroup("PythonFormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_group,
    pattern = "*.py",
    callback = function()
        -- Run Ruff to fix issues before saving
        vim.cmd([[silent! !ruff --fix %]])
    end,
})

local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
    cmd = { "gopls" },
    filetypes = { "go" },
    root_dir = require("lspconfig").util.root_pattern("go.mod", ".git"),
    settings = {
        gopls = {
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
        },
    },
})

lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--header-insertion=never",
        "--log=verbose",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "hpp", "h" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.ml",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

lspconfig.vtsls.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
    end,
})

require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
    },
})
