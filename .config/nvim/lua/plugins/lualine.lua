local config = function()
    require("lualine").setup({
        options = {
            theme = "auto",
            globalstatus = true,
            disabled_filetypes = { statusline = { "dashboard" } },
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { { "mode", icon = "" } },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                "filename",
            },
            lualine_x = {
                { "fileformat", padding = { left = 0, right = 1 } },
                { "encoding" },
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
    -- enabled = false,
}
