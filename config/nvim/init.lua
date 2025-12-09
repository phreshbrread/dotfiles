-- Ensure termguicolors is enabled if not already
vim.opt.termguicolors = true

-- Set options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cursorcolumn = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Load plugins
require('lualine').setup()
require('nvim-highlight-colors').setup({})

print("Test")
