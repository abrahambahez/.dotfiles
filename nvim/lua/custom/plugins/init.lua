-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'Kicamon/markdown-table-mode.nvim',
    config = function()
      require('markdown-table-mode').setup()
    end,
  },
  'nvim-pack/nvim-spectre',
  -- [sabhz]
  -- Markdown support
  'ixru/nvim-markdown',
  -- For dimming blocks
  -- {
  --   'folke/twilight.nvim',
  --   opts = {
  --     context = 10,
  --   },
  --},
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
      },
    },
  },
  --  For writing prose
  'preservim/vim-pencil',
  --  plugin to manage citations
  'nvim-telescope/telescope-bibtex.nvim',
  -- Telescope heading searches
  'crispgm/telescope-heading.nvim',
  -- LanguageTool Implementation
  -- 'rhysd/vim-grammarous'
  -- Focus mode
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 0.95,
        width = 75,
      },
      plugins = {
        alacritty = {
          enabled = true,
          font = '20', -- font size
        },
      },
      on_open = function()
        vim.g.markdown_zen_active = true
      end,
      on_close = function()
        vim.g.markdown_zen_active = false
      end,
    },
  },
  -- 'junegunn/goyo.vim',

  {
    'zk-org/zk-nvim',
    config = function()
      require('zk').setup {
        picker = 'telescope',
        lsp = {
          config = {
            cmd = { 'zk', 'lsp' },
            name = 'zk',
          },
        },
        auto_attach = {
          enabled = true,
          filetypes = { 'markdown', 'md' },
        },
      }
    end,
  },
}
