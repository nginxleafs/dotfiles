-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local detailed = false

vim.keymap.set("n", "<leader>uv", function()
  detailed = not detailed
  vim.diagnostic.config({
    virtual_text = detailed and { spacing = 4, prefix = "●" } or false,
    underline = detailed,
  })
  vim.notify("Подробная диагностика: " .. (detailed and "вкл" or "выкл"))
end, { desc = "Toggle detailed diagnostics" })
