-- Set options
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.syntax = 'on'
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.cmd('filetype plugin indent on')
vim.cmd('colorscheme tokyonight')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE') -- Transparent background

-- Custom keybinds
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>')

-- Load plugins
require('lualine').setup()
require('nvim-highlight-colors').setup({})

-- TODO switch vim.cmd to lua
-- TODO separate into options and keybinds files
    -- require('config.options') -- [./lua/options.lua]
    -- require('config.keybinds') -- [./lua/keybinds.lua]