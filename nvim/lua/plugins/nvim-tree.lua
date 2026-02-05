return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = {
        filters = {
            dotfiles = false,
        },
        view = {
            number = true,
            width = 40,
        },
        renderer = {
            -- indent_markers = {
            --     enable = true,
            --     inline_arrows = true,
            -- },
            highlight_git = true,
            highlight_modified = "all",
            highlight_opened_files = "all",
            highlight_diagnostics = true,
            icons = {
                git_placement = "after",
                -- web_devicons = {
                    -- folder = {
                        -- enable = true,
                        -- color = true,
                    -- },
                -- },
                show = {
                    folder_arrow = true,
                },
                glyphs = {
                    git = {
                        deleted   = " ", -- this can only be used in the git_status source
                        renamed   = "󰁕 ", -- this can only be used in the git_status source
                        untracked = " ",
                        ignored   = " ",
                        unstaged  = "󰄱 ",
                        staged    = " ",
                        unmerged  = " ",
                    },
                },
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },
    },
}
