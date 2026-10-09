return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 
        "nvim-treesitter/nvim-treesitter", 
        "nvim-tree/nvim-web-devicons"
    },
    ft = { "markdown", "quarto" }, -- Lazy-load on these file types
    opts = {},
}

