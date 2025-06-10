local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- COPY CURRENT FILE TO CLIPBOARD
vim.keymap.set('n', '<leader>cf', function()
  local filename = vim.fn.expand '%:t'
  if filename ~= '' then
    vim.fn.setreg('+', filename)
    print('Copied to clipboard: ' .. filename)
  else
    print 'No file to copy'
  end
end, { desc = 'Copy filename to clipboard' })

-- DELETE CURRENT FILE
vim.keymap.set('n', '<leader>df', function()
  local file = vim.fn.expand '%:p'
  if file ~= '' then
    local choice = vim.fn.confirm('Delete "' .. vim.fn.fnamemodify(file, ':t') .. '"?', '&Yes\n&No', 2)
    if choice == 1 then
      vim.cmd 'bdelete!'
      os.remove(file)
      print('Deleted: ' .. vim.fn.fnamemodify(file, ':t'))
    end
  end
end, { desc = 'Delete current file' })

-- MARKDOWN KEYMAPS
map('n', '<leader>sc', ':Telescope bibtex<CR>', { desc = 'Search BibTeX with Telescope' })

map('n', '<leader>st', ':Telescope heading<CR>', { desc = 'Search Heading with Telescope' })

-- ACTIVATE WRITING MODE (SEE autocmd.lua)
map('n', '<leader>zw', ':ToggleMarkdownZen<CR>')
map('n', '<leader>f', ':PencilSoft<CR>')

-- INDENTATION
-- Modo NORMAL y VISUAL: Tab indenta hacia la derecha, Shift+Tab hacia la izquierda
vim.keymap.set('n', '<Tab>', '>>', { noremap = true })
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true })

-- ZK KEYMAPS
local opts = { noremap = true, silent = false }

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.keymap.set('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

-- Open notes associated with the selected tags.
vim.keymap.set('n', '<leader>zt', '<Cmd>ZkTags<CR>', opts)

-- Search for the notes matching a given query.
-- vim.keymap.set('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
-- Search for the notes matching the current visual selection.
vim.keymap.set('v', '<leader>zF', ":'<,'>ZkMatch<CR>", opts)

vim.keymap.set('n', '<leader>zb', ':<Cmd>ZkBacklinks<CR>', opts)

vim.keymap.set('n', '<leader>zl', ':<Cmd>ZkLinks<CR>', opts)

vim.keymap.set('v', '<leader>zN', ":'<,'>ZkNewFromTitleSelection<CR>", opts)
