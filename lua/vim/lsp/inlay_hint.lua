-- Shim for nvim 0.11.x: vim/lsp/inlay_hint.lua sets an inline extmark at the
-- column the server reported without clamping it to the line, so a stale or
-- out-of-range column raises "Invalid 'col': out of range" from the decoration
-- provider on every redraw. Load the runtime module's source, splice in a
-- clamp, and return that instead. Shadows the runtime file because the config
-- dir precedes $VIMRUNTIME on 'runtimepath'.
local path = vim.env.VIMRUNTIME .. '/lua/vim/lsp/inlay_hint.lua'
local f = assert(io.open(path, 'r'), 'inlay_hint shim: cannot read ' .. path)
local src = f:read('*a')
f:close()

local pattern = 'for pos, vt in pairs%(hint_virtual_texts%) do'
local clamp = [[for pos, vt in pairs(hint_virtual_texts) do
          pos = math.min(pos, #(api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1] or ''))]]
local patched, n = src:gsub(pattern, clamp:gsub('%%', '%%%%'), 1)

-- n == 0 means upstream changed this code (likely fixed it); fall through to
-- the stock module rather than silently running a stale copy.
if n == 0 then
  return assert(loadfile(path))()
end
return assert(load(patched, '@' .. path))()
