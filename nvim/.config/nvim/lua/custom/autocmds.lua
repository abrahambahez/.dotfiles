local markdown_group = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })

-- Variable global para trackear el estado de ZenMode
vim.g.markdown_zen_active = false

-- Función para aplicar configuraciones básicas
local function apply_basic_settings()
  vim.opt_local.wrap = true
  vim.opt_local.spelllang = 'es,en'
  vim.opt_local.conceallevel = 2

  -- Cargar extensión bibtex de forma segura
  pcall(function()
    require('telescope').load_extension 'bibtex'
  end)
end

-- Función para activar ZenMode y PencilSoft
local function activate_zen_mode()
  -- Solo activamos si no está ya activo
  if not vim.g.markdown_zen_active then
    -- Verificamos si los comandos existen
    local function cmd_exists(command)
      return vim.fn.exists(':' .. command) == 2
    end

    -- Intentamos activar los comandos de forma segura
    if cmd_exists 'ZenMode' then
      pcall(vim.cmd, 'ZenMode')
      vim.g.markdown_zen_active = true
    end
    if cmd_exists 'PencilSoft' then
      pcall(vim.cmd, 'PencilSoft')
    end
  end
end

-- Función para desactivar ZenMode
local function deactivate_zen_mode()
  if vim.g.markdown_zen_active then
    if vim.fn.exists ':ZenMode' == 2 then
      pcall(vim.cmd, 'ZenMode')
      vim.g.markdown_zen_active = false
    end
  end
end

-- AutoCmd para configuraciones básicas
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'txt' },
  group = markdown_group,
  callback = function()
    apply_basic_settings()
    -- Activamos ZenMode solo si es el primer archivo markdown que se abre
    if not vim.g.markdown_zen_active then
      vim.defer_fn(activate_zen_mode, 100)
    end
  end,
})

-- AutoCmd para cuando sales de un archivo markdown
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = { '*.md', '*.txt' },
  group = markdown_group,
  callback = function()
    -- Verificamos si el siguiente buffer NO es markdown
    local next_ft = vim.bo.filetype
    if next_ft ~= 'markdown' and next_ft ~= 'txt' then
      vim.defer_fn(deactivate_zen_mode, 100)
    end
  end,
})

-- Comando para alternar ZenMode manualmente
vim.api.nvim_create_user_command('ToggleMarkdownZen', function()
  if vim.g.markdown_zen_active then
    deactivate_zen_mode()
  else
    activate_zen_mode()
  end
end, {})
