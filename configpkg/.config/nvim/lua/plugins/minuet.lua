return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
        n_completions = 1,
        context_window = 4056,

        -- автотриггер при наборе текста во всех типах файлов
        virtualtext = {
          auto_trigger_ft = { "*" },
          keymap = {
            accept = "<A-y>",
            accept_line = "<A-l>",
            next = "<A-]>",
            prev = "<A-[>",
            dismiss = "<A-e>",
          },
        },

        -- по желанию: быстрее реагировать (по умолчанию debounce 400, throttle 1000)
        debounce = 100,
        throttle = 300,

        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Llama.cpp",
            end_point = "http://192.168.3.121:8012/v1/completions",
            model = "PLACEHOLDER",

            optional = {
              max_tokens = 32,
              top_p = 0.9,
            },
            template = {
              prompt = function(context_before_cursor, context_after_cursor, _)
                return "<|fim_prefix|>"
                  .. context_before_cursor
                  .. "<|fim_suffix|>"
                  .. context_after_cursor
                  .. "<|fim_middle|>"
              end,
              suffix = false,
            },
          },
        },
      })
    end,
  },
}
