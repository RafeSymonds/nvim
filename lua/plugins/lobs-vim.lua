return {
    url = "git@github.com:lobs-ai/lobs-vim",
    opts = {
        -- Server URL
        server = "wss://nexus.lobslab.com",

        -- Cloudflare Access (auto-detected for *.lobslab.com, no secrets needed)
        cloudflare = {
            enabled = nil, -- nil = auto-detect from URL
        },

        -- UI
        sidebar_width = 60,
        sidebar_position = "right", -- "left" or "right"

        -- Context
        send_current_file = true,
        send_selection = true,
        max_context_lines = 500,

        -- Keymaps (false to disable)
        keymaps = {
            toggle = "<leader>aa",
            new_session = "<leader>ac",
            ask_selection = "<leader>as",
        },
    },
}
