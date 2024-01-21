return {
   "nvim-tree/nvim-tree.lua",
   lazy = false,
   opts = {
        filters = {
            dotfiles = true
        },
        view = {
            number = true,
            width = 40,
        },
        renderer = {
            indent_markers = {
                  enable = true,
            },
            highlight_git = true,
            highlight_modified = "all",
            highlight_opened_files = "all",
            highlight_diagnostics = true,
            icons = {
                git_placement = "before",
                web_devicons = {
                    folder = {
                        enable = true,
                        color = true,
                    },
                }
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },
   }
}
