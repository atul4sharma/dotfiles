-- [[ Basic Keymaps ]]
-- Plugin-specific keymaps live with their plugin under lua/plugins/.

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Strip the gutter so terminal-select copying grabs only the code
vim.keymap.set('n', '<F2>', function()
  vim.cmd ':setlocal number!'
  vim.cmd ':setlocal relativenumber!'
  vim.wo.signcolumn = vim.wo.signcolumn == 'auto' and 'no' or 'auto'
end, { desc = 'Toggle line numbers and signcolumn' })

-- Tab navigation
vim.keymap.set('n', '<F9>', 'gT', { desc = 'Previous tab' })
vim.keymap.set('n', '<F10>', 'gt', { desc = 'Next tab' })

-- Window navigation
-- NOTE: <c-k> is also mapped buffer-locally to signature help by the LSP
-- on_attach, which wins inside LSP-attached buffers.
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Resize current buffer by +/- 2 (used in split windows)
-- M corresponds to Option key (⌥) in mac and alt key elsewhere
vim.keymap.set('n', '<M-left>', ':vertical resize -2<cr>')
vim.keymap.set('n', '<M-down>', ':resize +2<cr>')
vim.keymap.set('n', '<M-up>', ':resize -2<cr>')
vim.keymap.set('n', '<M-right>', ':vertical resize +2<cr>')

-- Strip trailing whitespace
vim.keymap.set('n', '<Leader>wt', [[:%s/\s\+$//e<cr>]], { desc = '[W]hitespace [T]rim' })
