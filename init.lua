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

-- change autocomplete to tab instead of enter
-- local cmp = require("cmp")
-- cmp.setup({
--     mapping = {
--         ["<Tab>"] = cmp.mapping.confirm({ select = true }),
--     },
--     sources = {
--         { name = "nvim_lsp" },
--         --{ name = "buffer" },
--         { name = "path" },
--     },
-- })

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

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({})
-- REQUIRED
--
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
        .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        })
        :find()
end

vim.keymap.set("n", "<M-e>", function()
    toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Add to harpoon" })

vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon quick menu" })

vim.keymap.set("n", "<C-h>", function()
    harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
    harpoon:list():select(2)
end)
-- vim.keymap.set("n", "<C-n>", function()
--     harpoon:list():select(3)
-- end)
-- vim.keymap.set("n", "<C-s>", function()
--     harpoon:list():select(4)
-- end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function()
    harpoon:list():prev()
end)
vim.keymap.set("n", "<C-n>", function()
    harpoon:list():next()
end)

vim.keymap.set("n", "<C-c>", function()
    harpoon:list():clear()
end, { desc = "Clear harpoon list" })

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.ml",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
