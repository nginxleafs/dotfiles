return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false, -- текст справа от строки (есть float по <leader>cd / cursor)
        underline = true,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
      },
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = false,
      },
      -- Глобальные настройки для всех LSP (capabilities от blink.cmp и UI)
      servers = {
        ["*"] = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
          keys = {
            { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
          },
        },
      },
    },
    init = function()
      -- Скруглённые рамки для LSP hover/signature
      local orig = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig(contents, syntax, opts, ...)
      end
    end,
  },
}
