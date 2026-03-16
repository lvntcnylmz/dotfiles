return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics = opts.diagnostics or {}
    opts.diagnostics.virtual_text = opts.diagnostics.virtual_text or {}

    opts.diagnostics.virtual_text.prefix = "■" -- istediğin karakter

    return opts
  end,
}
