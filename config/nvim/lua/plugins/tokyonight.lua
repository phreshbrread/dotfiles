return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- Load before everything else
    config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme tokyonight]])
    end,
}
