-- The Dafny language server embeds raw HTML in hover text (it targets VSCode's
-- markdown renderer, which allows HTML). Neovim shows the tags literally, e.g.
--   <span style='color:green'>**Success:**</span> target object is never null
-- Only strip tags Dafny actually emits. A generic `<[^>]+>` would also eat
-- Dafny generics like `array<int>` out of the fenced code block in the hover,
-- and single-letter tags are left out because `<b>` / `<i>` are legal Dafny
-- type arguments.
local HTML_TAGS = { "span", "font", "strong", "em" }

local function strip_html(s)
  s = s:gsub("<[bB][rR]%s*/?>", "\n")
  for _, tag in ipairs(HTML_TAGS) do
    s = s:gsub("<" .. tag .. "%s[^>]*>", "")
    s = s:gsub("<" .. tag .. ">", "")
    s = s:gsub("</" .. tag .. ">", "")
  end
  return s
end

local function sanitize_contents(contents)
  if type(contents) == "string" then
    return strip_html(contents)
  elseif type(contents) == "table" then
    if type(contents.value) == "string" then
      contents.value = strip_html(contents.value)
    else
      for i, part in ipairs(contents) do
        contents[i] = sanitize_contents(part)
      end
    end
  end
  return contents
end

return {
  -- Unofficial Dafny grammar (hath995/tree-sitter-dafny), not in
  -- nvim-treesitter's registry. Registration goes through the `User TSUpdate`
  -- autocmd rather than a one-shot assignment: install.lua's reload_parsers()
  -- clears package.loaded for the parser table and re-fires TSUpdate, so a
  -- plain `parsers.dafny = ...` is wiped before the install ever reads it.
  -- Queries are vendored in ~/.config/nvim/queries/dafny/ from the same pin.
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        group = vim.api.nvim_create_augroup("dafny_ts_parser", { clear = true }),
        callback = function()
          require("nvim-treesitter.parsers").dafny = {
            install_info = {
              url = "https://github.com/hath995/tree-sitter-dafny",
              revision = "8085572ab23ba703a1f5c1cf753136a3508c68a6",
            },
            tier = 3,
          }
        end,
      })
    end,
    opts = { ensure_installed = { "dafny" } },
  },

  -- Kept as the fallback highlighter: it still owns .dfy files whenever the
  -- tree-sitter parser is missing or fails to build.
  {
    "mlr-msft/vim-loves-dafny",
    ft = "dafny",
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dafny = {
          mason = false, -- using the Homebrew `dafny`
          cmd = {
            "dafny",
            "server",
            "--verify-on:Save", -- Never | Save | Change | ChangeProject
          },
          filetypes = { "dafny" },
          root_markers = { "dfyconfig.toml", ".git" },
          -- Neovim 0.11's vim.lsp.buf.hover() renders the float itself and never
          -- dispatches through client.handlers, so wrap the request instead.
          on_attach = function(client)
            local request = client.request
            client.request = function(self, method, params, handler, bufnr)
              if method == "textDocument/hover" and handler then
                local inner = handler
                handler = function(err, result, ctx, config)
                  if result and result.contents then
                    result.contents = sanitize_contents(result.contents)
                  end
                  return inner(err, result, ctx, config)
                end
              end
              return request(self, method, params, handler, bufnr)
            end
          end,
        },
      },
    },
  },

  -- The Dafny LSP advertises no documentFormattingProvider, so conform had
  -- nothing to fall back to. `dafny format` is the actual formatter.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        dafny = { "dafny_format" },
      },
      formatters = {
        dafny_format = {
          command = "dafny",
          args = { "format", "$FILENAME" },
          stdin = false, -- rewrites the file in place
          -- Dafny exits 2 when the file does not parse. Leave that as a failure
          -- so a save that cannot format says so, instead of silently no-oping.
          exit_codes = { 0 },
        },
      },
    },
  },
}
