-------------------
--- NVIM CONFIG ---
-------------------

-- Load lazy.nvim plugin manager
require("config.lazy")

-- Load keybinds
require("config.keybinds")

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
vim.o.splitright = true
vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Transparent background
vim.opt.shortmess:append "I" -- Disable intro message

-- Enable instant bracket wrapping around selection
vim.keymap.set("v", "(", 'c()<Esc>P', { remap = false })
vim.keymap.set("v", "[", 'c[]<Esc>P', { remap = false })
vim.keymap.set("v", "{", 'c{}<Esc>P', { remap = false })

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

-- Create an autocmd group to isolate Telescope tweaks
local telescope_autocomplete_group = vim.api.nvim_create_augroup("TelescopeNativeAutocomplete", { clear = true })

-- Disable autocomplete inside Telescope prompt
vim.api.nvim_create_autocmd("FileType", {
  group = telescope_autocomplete_group,
  pattern = "TelescopePrompt",
  callback = function()
    -- Disable autocomplete for this specific buffer
    vim.opt_local.autocomplete = false

    -- Clear complete sources list so it won't fetch omnifunc / buffer words
    vim.opt_local.complete = ""
  end,
})
