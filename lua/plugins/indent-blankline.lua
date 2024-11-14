return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = function()
        -- Set highlight for indentation guides
        vim.cmd([[highlight IndentBlanklineChar guifg=#111111 ctermfg=black]])

        return {
            indent = {
                smart_indent_cap = true,
                priority = 2,
                repeat_linebreak = false,
            },
            scope = {
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        }
    end,
    main = "ibl",
}
