return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      timeout = vim.o.timeoutlen,
      default_mappings = false,
      mappings = {
        i = {
          j = {
            k = "<Esc>",
          },
        },
        c = {
          j = {
            k = "<Esc>",
          },
        },
        t = {
          j = {
            k = "<C-\\><C-n>",
          },
        },
      },
    },
  },
}