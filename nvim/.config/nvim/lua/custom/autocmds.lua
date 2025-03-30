local markdown_group = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })

-- NOTE: Global variable to track Zen Mode State is
-- `vim.g.markdown_zen_active` and its declared
-- in ZenMode options 'lua/custom/plugins/init.lua'

-- Function to apply basic settings
local function apply_basic_settings()
  vim.opt_local.wrap = true
  vim.opt_local.spelllang = 'es,en'
  vim.opt_local.conceallevel = 2
  -- Cargar extensión bibtex de forma segura
  pcall(function()
    require('telescope').load_extension 'bibtex'
  end)
end

-- Activate Zen Mode
local function activate_zen_mode()
  -- Solo activamos si no está ya activo
  if not vim.g.markdown_zen_active then
    -- Verify if cmd exist
    local function cmd_exists(command)
      return vim.fn.exists(':' .. command) == 2
    end
    if cmd_exists 'ZenMode' and cmd_exists 'PencilSoft' then
      vim.cmd 'ZenMode'
      vim.cmd 'PencilSoft'
      print('Markdown Zen Active: ' .. tostring(vim.g.markdown_zen_active))
    end
  end
end

-- Función para desactivar ZenMode
local function deactivate_zen_mode()
  -- Verify if cmd exist
  local function cmd_exists(command)
    return vim.fn.exists(':' .. command) == 2
  end
  -- Deactivate
  if cmd_exists 'ZenMode' and cmd_exists 'Pencil' then
    vim.cmd 'ZenMode'
    vim.cmd 'PencilOff'
    print('Markdown Zen Active: ' .. tostring(vim.g.markdown_zen_active))
  end
end

-- AutoCmd for basic setting
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'txt' },
  group = markdown_group,
  callback = function()
    apply_basic_settings()
    vim.defer_fn(activate_zen_mode, 100)
  end,
})

-- AutoCmd para manejar conmutación de buffers markdown/txt
-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = { '*.md', '*.txt' },
--   group = markdown_group,
--   callback = function()
--     -- Activar ZenMode solo si no está activo
--     if not vim.g.markdown_zen_active then
--       vim.defer_fn(activate_zen_mode, 100)
--     end
--   end,
-- })
--
-- -- AutoCmd para cuando sales de un archivo markdown
-- vim.api.nvim_create_autocmd('BufLeave', {
--   pattern = { '*.md', '*.txt' },
--   group = markdown_group,
--   callback = function()
--     -- Obtener el próximo buffer
--     local next_buf = vim.fn.bufnr '#'
--     -- Use vim.bo to get buffer-local options (replaces deprecated nvim_buf_get_option)
--     local next_ft = vim.bo[next_buf].filetype
--
--     -- Desactivar ZenMode si el próximo buffer NO es markdown/txt
--     if next_ft ~= 'markdown' and next_ft ~= 'txt' then
--       vim.defer_fn(deactivate_zen_mode, 100)
--     end
--   end,
-- })
--
-- Comando para alternar ZenMode manualmente
vim.api.nvim_create_user_command('ToggleMarkdownZen', function()
  if vim.g.markdown_zen_active then
    deactivate_zen_mode()
  else
    activate_zen_mode()
  end
end, {})

-- Comando para mostrar estado actual de ZenMode
vim.api.nvim_create_user_command('ShowMarkdownZenStatus', function()
  print('Markdown Zen Active: ' .. tostring(vim.g.markdown_zen_active))
end, {})
