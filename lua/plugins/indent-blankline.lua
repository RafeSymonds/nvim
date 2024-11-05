return {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = function()
        LazyVim.toggle.map("<leader>ug", {
            name = "Indention Guides",
            get = function()
                return require("ibl.config").get_config(0).enabled
            end,
            set = function(state)
                require("ibl").setup_buffer(0, { enabled = state })
            end,
        })

        vim.cmd([[highlight IndentBlanklineChar guifg=#111111  ctermfg=black]]) -- Adjust brightness here

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
