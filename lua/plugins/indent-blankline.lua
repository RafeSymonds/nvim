return {
    -- Disable the indent-blankline plugin
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false, -- This line disables the plugin
    },

    -- Install yggdroot/indentLine with custom settings
    {
        "yggdroot/indentLine",
        event = "BufReadPost", -- Trigger plugin when a file is read
        config = function()
            -- Optional: Customization options (e.g., colors)
            vim.g.indentLine_char = "|" -- Character for indentation lines
            vim.g.indentLine_color_term = 235 -- Darker color (you can adjust this to your terminal theme)
            vim.g.indentLine_guifg = "#3e3e3e" -- GUI color for darker line (hex color for GUI)

            -- Set position of the indent line (most left)
            vim.g.indentLine_setColors = 0 -- Disable additional colorization
            vim.g.indentLine_fileTypeExclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" } -- Exclude certain file types
        end,
    },
}
