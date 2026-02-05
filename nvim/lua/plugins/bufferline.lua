return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    opts.options.always_show_bufferline = true
    opts.options.offsets = {
      {
        filetype = "snacks_layout_box",
        text = ", File Explorer",
        separator = false,
      },
    }
  end,
}
