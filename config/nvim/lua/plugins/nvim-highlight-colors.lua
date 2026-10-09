return {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" }, -- Lazy load on file open
    opts = {
        render = 'background',
    },
}
