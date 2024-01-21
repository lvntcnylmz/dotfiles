local opts = {
    ensure_installed = {
        "efm",
        "bashls",
        "tsserver",
        "lua_ls",
        "rust_analyzer",
        "jdtls"
    },

    automatic_instllation = true,
}

return {
    "williamboman/mason-lspconfig.nvim",
    opts = opts,
    event = "BufReadPre",
}
