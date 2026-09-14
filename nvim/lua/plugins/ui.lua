-- Colorscheme, statusline and indentation guides.
return {
  'nvim-tree/nvim-web-devicons',

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
      -- NOTE: must run *after* the colorscheme -- loading a colorscheme clears
      -- user highlights, so setting this any earlier is a no-op.
      vim.cmd 'highlight ColorColumn ctermbg=gray'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    -- See `:help ibl`
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local enable_rainbow_color_indent = false
      local hooks = require 'ibl.hooks'

      -- Toggles between plain whitespace guides and rainbow-coloured ones.
      local function modify_indent_style()
        if enable_rainbow_color_indent then
          local highlight = {
            'RainbowRed',
            'RainbowYellow',
            'RainbowBlue',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowViolet',
            'RainbowCyan',
          }

          -- create the highlight groups in the highlight setup hook, so they are reset
          -- every time the colorscheme changes
          hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
            vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
            vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
            vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
            vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
            vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
            vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
          end)

          require('ibl').setup { indent = { highlight = highlight } }
        else
          local highlight = {
            'CursorColumn',
            'Whitespace',
          }

          require('ibl').setup {
            indent = { highlight = highlight, char = '' },
            whitespace = {
              highlight = highlight,
              remove_blankline_trail = false,
            },
            scope = { enabled = false },
          }
        end
        enable_rainbow_color_indent = not enable_rainbow_color_indent
      end

      -- Initial indent style
      modify_indent_style()

      vim.keymap.set('n', '<F3>', modify_indent_style, { desc = 'Toggle rainbow indent guides' })
    end,
  },
}
