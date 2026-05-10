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
