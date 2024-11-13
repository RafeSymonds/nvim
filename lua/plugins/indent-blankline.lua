return {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = function()
        -- Define toggle functionality manually
        vim.keymap.set("n", "<leader>ug", function()
            local state = not require("ibl.config").get_config(0).enabled
            require("ibl").setup_buffer(0, { enabled = state })
            print("Indentation Guides " .. (state and "Enabled" or "Disabled"))
        end, { desc = "Toggle Indentation Guides" })

        vim.cmd([[highlight IndentBlanklineChar guifg=#111111 ctermfg=black]]) -- Adjust brightness here

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
