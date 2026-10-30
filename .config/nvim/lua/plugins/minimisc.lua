return {
  {
    "nvim-mini/mini.misc",
    version = "*",
    lazy = false,
    config = function()
      require("mini.misc").setup_termbg_sync()
    end,
  },
}
