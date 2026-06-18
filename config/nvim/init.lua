-----------------
-- NVIM CONFIG --
-----------------

-- Plugins are installed/managed by Nix, but are configured/loaded here

-- Load split configs
require('keybinds')

-- Options
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.syntax = 'on'
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.api.nvim_command('filetype plugin indent on')

-- Disable intro message
vim.opt.shortmess:append "I"

-- Load plugins
require('lualine').setup()
require('nvim-highlight-colors').setup({})
require('nvim-autopairs').setup({})

-- Colours
vim.cmd.colorscheme "tokyonight"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Transparent background

-- Tree-sitter
require('nvim-treesitter').setup({})
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    pcall(vim.treesitter.start)   -- pcall so it doesn't error on unsupported files
  end,
})

-- Markdown rendering
require('render-markdown').setup({})

-- Discord RPC
require("presence").setup({
    -- General options
    auto_update         = true,                 -- Update activity based on autocmd events
    neovim_image_text   = "Guh",                -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",             -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371", -- Use your own Discord application client id (not recommended)
    log_level           = nil,                  -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                   -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                -- Displays the current line number instead of the current project
    blacklist           = {},                   -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                 -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                   -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,

    -- Rich Presence text options
    editing_text        = "Editing %s",     -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",    -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    workspace_text      = "Working on %s",  -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
})

-- LSP config
vim.lsp.enable({ 'clangd', 'rust_analyzer' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
        end
    end,
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.complete:append('o')
vim.o.autocomplete = true
vim.o.pumheight = 6
vim.o.pumborder = 'rounded'
