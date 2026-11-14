return {
  {
    "sudo-tee/opencode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "opencode_output" },
      },
      "folke/snacks.nvim",
    },
    opts = {
      ui = {
        position = "right",
        window_width = 0.5,
      },
    },
    config = function(_, opts)
      require("opencode").setup(opts)
    end,
  },
}