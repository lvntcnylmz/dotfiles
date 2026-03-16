return {
  "alexpasmantier/krust.nvim",
  ft = "rust",
  opts = {
    keymap = "<leader>k", -- Set a keymap for Rust buffers (default: false)
    float_win = {
      border = "single", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
      auto_focus = false, -- Auto-focus float (default: false)
    },
  },
}
