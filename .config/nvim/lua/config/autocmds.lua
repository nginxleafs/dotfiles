-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local in_text = false

local EN_IDX = 0 -- номер английской раскладки в niri

local function to_english()
  vim.system({ "niri", "msg", "action", "switch-layout", tostring(EN_IDX) })
end

vim.api.nvim_create_autocmd("InsertLeave", { callback = to_english })

vim.api.nvim_create_autocmd("CursorMovedI", {
  callback = function()
    local ok, node = pcall(vim.treesitter.get_node)
    local t = ok and node and node:type() or ""
    local now = t == "string_content" or t == "string" or t == "comment"
    if in_text and not now then
      to_english()
    end
    in_text = now
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    in_text = false
  end,
})

local function osc(seq)
  if vim.env.TMUX then
    seq = "\027Ptmux;" .. (seq:gsub("\027", "\027\027")) .. "\027\\"
  end
  io.stdout:write(seq)
end

local function sync_bg()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  if normal.bg then
    osc(string.format("\027]11;#%06x\007", normal.bg))
  end
end

-- vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, { callback = sync_bg })
-- vim.api.nvim_create_autocmd({ "UILeave", "VimLeavePre" }, {
--   callback = function()
--     osc("\027]111;\007")
--   end, -- вернуть исходный фон
-- })
local group = vim.api.nvim_create_augroup("termbg", { clear = true })

vim.api.nvim_create_autocmd({ "UIEnter", "FocusGained" }, {
  group = group,
  callback = sync_bg,
})

vim.api.nvim_create_autocmd({ "FocusLost", "UILeave", "VimLeavePre" }, {
  group = group,
  callback = function()
    osc("\027]111;\007")
  end,
})
