return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = {
        {
            "<leader>cd",
            function()
                require("neogen").generate()
            end,
            desc = "Generate Docstring",
        },
    },
}
