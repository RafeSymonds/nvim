return {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("flow").setup({
            transparent = false, -- Set transparent background.
            fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
            mode = "normal", -- Intensity of the palette: normal, bright, desaturate, or dark. Notice that dark is ugly!
            aggressive_spell = false, -- Display colors for spell check.
        })

        vim.cmd("colorscheme flow")
    end,
}
-- return {
--     -- Other plugins ...
--
--     "lancewilhelm/horizon-extended.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("horizon-extended").setup({
--             style = "neo",
--             transparent = false,
--             terminal_colors = true,
--             enable_italics = false,
--             show_end_of_buffer = false,
--             underline = false,
--             undercurl = true,
--             styles = {
--                 booleans = { italic = false, bold = false },
--                 comments = { italic = false, bold = false },
--                 conditionals = { italic = false, bold = false },
--                 delimiters = { italic = false, bold = false },
--                 functions = { italic = false, bold = false },
--                 keywords = { italic = false, bold = false },
--                 loops = { italic = false, bold = false },
--                 operators = { italic = false, bold = false },
--                 properties = { italic = false, bold = false },
--                 strings = { italic = false, bold = false },
--                 types = { italic = false, bold = false },
--                 variables = { italic = false, bold = false },
--             },
--         })
--         vim.cmd("colorscheme horizon-extended")
--     end,
-- }
