-- ~/.config/nvim/lua/plugins/markdown-preview.lua
return {
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
        keys = {
            {
                "<leader>mp",
                "<cmd>MarkdownPreview<cr>",
                desc = "Preview Markdown",
            },
            {
                "<leader>ms",
                "<cmd>MarkdownPreviewStop<cr>",
                desc = "Stop Preview",
            },
            {
                "<leader>mt",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Toggle Preview",
            },
        },
    },
}
