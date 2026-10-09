--[[ CUSTOM BINDS ]]--

-- Telescope
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<C-l>', '<cmd>Telescope live_grep<CR>')

-- LSP diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)

-- Auto indent in place
vim.keymap.set('n', '<C-f>', 'mzgg=G`z')

-- Split & cargo run
vim.keymap.set('n', '<A-c>', '<cmd>vsplit | terminal cargo run<CR>')

-- Find references using LSP in normal mode
vim.keymap.set('n', '<A-r>', vim.lsp.buf.references, { desc = 'Find references (Alt+r)' })

-- Map escape to exit terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

