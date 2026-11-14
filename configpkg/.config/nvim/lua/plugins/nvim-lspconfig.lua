return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false, -- текст справа от строки
        underline = false, -- волнистое подчёркивание
        signs = true, -- значок в колонке слева
        update_in_insert = false,
      },
    },
  },
}
