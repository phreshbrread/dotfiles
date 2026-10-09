return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate", 
    config = function()
        require("nvim-treesitter.config").setup({
            -- Auto install parser when entering a file
            auto_install = true,
        })
    end,
}
