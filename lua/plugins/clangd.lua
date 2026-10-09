-- Flag overrides for the clangd that LazyVim's lang.clangd extra starts.
-- Mutates the default cmd in place instead of replacing it, because LazyVim
-- deep-merges opts by index and a shorter replacement list would leave the
-- tail of the default flags attached.
return {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        local cmd = vim.tbl_get(opts, "servers", "clangd", "cmd")
        if not cmd then
            return
        end
        for i, arg in ipairs(cmd) do
            if arg:match("^%-%-header%-insertion=") then
                cmd[i] = "--header-insertion=never"
            end
        end
    end,
}
