return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            compile = false,
            undercurl = true,
            commentStyle = { italic = false },
            functionStyle = { fg = "#0c89c7" },
            keywordStyle = { italic = false },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,
            dimInactive = false,
            terminalColors = true,
            colors = {
                palette = {
                    wave = {
                        bg = "#1a1c24", -- Base background color
                        sign_bg = "#2b2b2b", -- Background for sign column
                        line_nr_bg = "#1b1d24", -- Slightly similar color for line numbers
                        cmd_bg = "#007acc", -- Background color for the command line (more blue)
                        lighter_blue = "#00aaff", -- Lighter blue for command line
                        dropdown_bg = "#242445", -- Background color for dropdown menus
                        dropdown_sel_bg = "#191524", -- Selected item background in dropdown
                        dropdown_sel_fg = "#ffffff", -- Selected item foreground in dropdown
                        intellisense_bg = "#191524", -- Darker purple for Intellisense backgrounds
                    },
                },
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors)
                return {
                    Normal = { bg = colors.palette.wave.bg },
                    YankHighlight = { bg = "#2d2d2d", fg = colors.fg }, -- Darker yank color
                    Visual = { bg = "#4a4a4a" }, -- Visual mode background color
                    VisualNOS = { bg = "#4a4a4a" }, -- Visual mode background color (non-operator)
                    Pmenu = { bg = colors.palette.wave.dropdown_bg, fg = "#ffffff" }, -- Background and text color for dropdown menus
                    PmenuSel = {
                        bg = colors.palette.wave.dropdown_sel_bg,
                        fg = colors.palette.wave.dropdown_sel_fg,
                        bold = true,
                    }, -- Selected item in dropdown
                    PmenuThumb = { bg = colors.palette.intellisense_bg }, -- Scrollbar in the dropdown menu
                    SignColumn = { bg = colors.palette.wave.sign_bg }, -- Background for sign column
                    LineNr = { bg = colors.palette.wave.line_nr_bg, fg = "#b0b0b0" }, -- Line numbers with subtle background color
                    CursorLineNr = { bg = colors.palette.wave.bg, fg = "#00aaff", bold = true, italic = true }, -- Highlight current line number with bright blue
                    StatusLine = { bg = colors.palette.wave.cmd_bg, fg = "#ffffff", bold = true }, -- Command line status
                    CmdLine = { bg = colors.palette.wave.cmd_bg, fg = "#ffffff", bold = true }, -- Command line background
                    CmdLineInfo = { bg = colors.palette.wave.cmd_bg, fg = "#ffffff", bold = true }, -- Command line info
                    CmdLinePrompt = { bg = colors.palette.wave.lighter_blue, fg = "#ffffff" }, -- Lighter blue for the prompt
                    CmdLineNormal = { bg = colors.palette.wave.cmd_bg, fg = "#ffffff" }, -- Input box background and text color
                    CmdLineInsert = { bg = colors.palette.wave.lighter_blue, fg = "#ffffff" }, -- Lighter blue for the command line insert mode
                }
            end,
            theme = "wave", -- Load "wave" theme when 'background' option is not set
            background = {
                dark = "wave",
                light = "wave",
            },
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd("colorscheme kanagawa")
        end,
    },
}

-- return {
--     "0xstepit/flow.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function()
--         require("flow").setup({
--             transparent = false, -- Set transparent background.
--             fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
--             mode = "bright", -- Intensity of the palette: normal, bright, desaturate, or dark. Notice that dark is ugly!
--             aggressive_spell = false, -- Display colors for spell check.
--         })
--
--         vim.cmd("colorscheme flow")
--     end,
-- }
-- return {
--     -- Other plugins ...
--
--     "kevincal1226/horizon-extended.nvim",
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
