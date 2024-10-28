local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- MARKDOWN KEYMAPS
map('n', '<leader>sc', ':Telescope bibtex<CR>', { desc = 'Search BibTeX with Telescope' })

map('n', '<leader>mt', ':Telescope heading<CR>', { desc = 'Search BibTeX with Telescope' })

-- INDENTATION
-- Modo NORMAL y VISUAL: Tab indenta hacia la derecha, Shift+Tab hacia la izquierda
vim.keymap.set('n', '<Tab>', '>>', { noremap = true })
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true })
