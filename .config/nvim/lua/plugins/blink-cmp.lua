local function underscore_last(a, b)
  local au = a.label:find("^_") ~= nil
  local bu = b.label:find("^_") ~= nil
  if au ~= bu then
    return bu -- a идёт раньше, если b начинается с "_"
  end
end

return {
  {
    "saghen/blink.cmp",
    event = "LspAttach",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
    },
    build = function()
      require("blink.cmp").build():pwait()
    end,
    opts = {
      keymap = { preset = "default" },
      completion = {
        menu = { auto_show = false },
        documentation = { auto_show = false },
        ghost_text = { enabled = true },
        trigger = {
          show_on_insert = false,
        },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust", sorts = { "exact", underscore_last, "score", "sort_text" } },
    },
  },
}
