--[[ CUSTOM BINDS ]]--

-- Telescope
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>')
vim.keymap.set('n', '<C-l>', ':Telescope live_grep<CR>')

-- LSP diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)

-- Auto indent in place
vim.keymap.set('n', '<C-f>', 'mzgg=G`z')
