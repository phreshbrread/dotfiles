return {
    {
        "andweeb/presence.nvim",
        event = "VeryLazy", -- Load after startup to avoid slowdowns
        opts = {
            -- General options
            auto_update        = true,
            neovim_image_text  = "Fuck yer electron editors",
            main_image         = "neovim",
            client_id          = "793271441293967371",
            log_level          = nil,
            debounce_timeout   = 10,
            enable_line_number = false,
            blacklist          = {},
            buttons            = true,
            file_assets        = {},
            show_time          = true,

            -- Rich Presence text options
            editing_text       = "Editing %s",
            file_explorer_text = "Browsing %s",
            workspace_text     = "Working on %s",
        },
    },
}
