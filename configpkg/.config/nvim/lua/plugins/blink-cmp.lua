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
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          auto_show = false,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = true,
        },
        list = {
          max_items = 3,
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        trigger = {
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_insert = false,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          lsp = {
            score_offset = 10,
            fallbacks = { "buffer" },
          },
          path = {
            score_offset = 3,
          },
          snippets = {
            score_offset = 0,
          },
          buffer = {
            score_offset = -3,
            min_keyword_length = 2,
          },
          copilot = {
            name = "Copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 1,
              max_attempts = 4,
              debounce = 200,
            },
          },
        },
      },

      signature = {
        enabled = true,
        window = {
          border = "rounded",
          show_documentation = true,
        },
      },

      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
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
