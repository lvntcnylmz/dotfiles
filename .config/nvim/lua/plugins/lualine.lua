local config = function()
    require("lualine").setup({
        options = {
            theme = "auto",
            globalstatus = true,
            component_separators = { left = "󰇙", right = "󰇙" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { { "mode", icon = "" } },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = {
                "encoding",
                {
                    "fileformat",
                    symbols = {
                        unix = "󰣇",
                    },
                },
                "filetype",
            },
            lualine_y = {
                { "progress", separator = "", padding = { left = 1, right = 0 } },
                { "location", padding = { left = 0, right = 1 } },
            },
            lualine_z = {
                {
                    "datetime",
                    style = " %a, %d %b %R",
                },
            },
        },
        tabline = {},
    })
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = config,
}
