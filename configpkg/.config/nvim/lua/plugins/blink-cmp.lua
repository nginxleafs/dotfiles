local function underscore_last(a, b)
  local au = a.label:find("^_") ~= nil
  local bu = b.label:find("^_") ~= nil

  if au ~= bu then
    return bu
  end
end

return {
  {
    "saghen/blink.cmp",
    event = "LspAttach",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
    },
    build = function()
      require("blink.cmp").build():pwait()
    end,
    opts = {
      keymap = {
        preset = "default",
      },

      completion = {
        menu = {
          auto_show = false,
        },
        documentation = {
          auto_show = false,
        },
        ghost_text = {
          enabled = false,
        },
        trigger = {
          show_on_insert = false,
        },
      },

      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "copilot",
        },

        providers = {
          copilot = {
            name = "Copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 3,
              max_attempts = 4,
              debounce = 200,
            },
          },
        },
      },

      signature = {
        enabled = true,
      },

      fuzzy = {
        implementation = "prefer_rust",
        sorts = {
          "exact",
          underscore_last,
          "score",
          "sort_text",
        },
      },
    },
  },
}
