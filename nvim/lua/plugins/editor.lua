-- Small editing-quality plugins that need little or no configuration.
return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    -- Markdown rendering in the buffer
    'OXY2DEV/markview.nvim',
    lazy = false,
  },

  {
    -- To open file at the last place
    'farmergreg/vim-lastplace',
    config = function()
      vim.g.lastplace_ignore = 'gitcommit,gitrebase,svn,hgcommit'
    end,
  },

  {
    'eriks47/generate.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
