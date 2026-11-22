-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.cursorline = false
vim.opt.guicursor = "n-v-c:ver25,i-ci:ver25,r-cr:ver25"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    vim.bo[args.buf].formatoptions = vim.bo[args.buf].formatoptions:gsub("[o]", "")
  end,
})
