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

vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
