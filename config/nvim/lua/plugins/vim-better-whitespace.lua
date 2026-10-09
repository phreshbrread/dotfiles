return {
    "ntpeters/vim-better-whitespace",
    event = "VeryLazy",
    init = function()
        -- Auto strip on save
        vim.g.strip_whitespace_on_save = 1

        -- Disable strip confirmation
        vim.g.strip_whitespace_confirm = 0
    end,
}
