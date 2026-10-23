--[[ CUSTOM BINDS ]]--

-- Telescope
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<C-l>', '<cmd>Telescope live_grep<CR>')

-- LSP diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)

-- Auto indent in place
vim.keymap.set('n', '<C-f>', 'mzgg=G`z')

-- Split & build using makefile
vim.keymap.set('n', '<A-b>', function()
  vim.cmd('vsplit')
  vim.cmd('terminal make')
  vim.cmd('startinsert')
end)

-- Open Lazy
vim.keymap.set('n', '<A-l>', '<cmd>Lazy<CR>')

-- Split & execute makefile run target
vim.keymap.set('n', '<A-c>', function()
  vim.cmd('vsplit')
  vim.cmd('terminal make run')
  vim.cmd('startinsert')
end)

-- Find references using LSP in normal mode
vim.keymap.set('n', '<A-r>', vim.lsp.buf.references, { desc = 'Find references (Alt+r)' })

-- Map escape to exit terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Enable instant bracket wrapping around selection
vim.keymap.set("v", "(", "c()<Esc>P", { remap = false })
vim.keymap.set("v", "[", "c[]<Esc>P", { remap = false })
vim.keymap.set("v", "{", "c{}<Esc>P", { remap = false })

