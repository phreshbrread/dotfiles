-----------------
-- NVIM CONFIG --
-----------------

-- Plugins are installed/managed by Nix, but are configured/loaded here

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
vim.cmd('filetype plugin indent on') -- TODO switch this to lua equivalent

-- Custom keybinds
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>')

-- Load plugins
require('lualine').setup()
require('nvim-highlight-colors').setup({})
require("nvim-treesitter.configs").setup({})

-- TODO separate into options and keybinds files
-- require('config.options') -- [./lua/options.lua]
-- require('config.keybinds') -- [./lua/keybinds.lua]

-- Set colours
vim.cmd.colorscheme "tokyonight"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Transparent background
