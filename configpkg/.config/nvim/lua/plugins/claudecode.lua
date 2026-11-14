return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = true,
    keys = {
      {
        "<leader>ac",
        "<cmd>ClaudeCode<cr>",
        desc = "Claude Code",
      },
      {
        "<leader>af",
        "<cmd>ClaudeCodeFocus<cr>",
        desc = "Focus Claude Code",
      },
      {
        "<leader>as",
        "<cmd>ClaudeCodeSend<cr>",
        mode = { "n", "v" },
        desc = "Send to Claude Code",
      },
      {
        "<leader>ar",
        "<cmd>ClaudeCode --resume<cr>",
        desc = "Resume Claude Code",
      },
    },
  },
}
