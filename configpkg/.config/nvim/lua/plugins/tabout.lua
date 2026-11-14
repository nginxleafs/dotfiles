return {
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- не перехватываем Tab/S-Tab глобально, чтобы не конфликтовать с blink.cmp
      tabkey = "",
      backwards_tabkey = "",
      act_as_tab = true,
      act_as_shift_tab = false,
      default_tab = "<C-t>",
      default_shift_tab = "<C-d>",
      enable_backwards = true,
      completion = false,
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
      ignore_beginning = true,
      exclude = {},
    },
    keys = {
      {
        "<Tab>",
        function()
          if vim.snippet and vim.snippet.active({ direction = 1 }) then
            return "<cmd>lua vim.snippet.jump(1)<cr>"
          end
          return "<Plug>(Tabout)"
        end,
        mode = "i",
        expr = true,
        silent = true,
        desc = "Snippet jump or tabout",
      },
      {
        "<S-Tab>",
        function()
          if vim.snippet and vim.snippet.active({ direction = -1 }) then
            return "<cmd>lua vim.snippet.jump(-1)<cr>"
          end
          return "<Plug>(TaboutBack)"
        end,
        mode = "i",
        expr = true,
        silent = true,
        desc = "Snippet jump back or tabout back",
      },
    },
  },
}