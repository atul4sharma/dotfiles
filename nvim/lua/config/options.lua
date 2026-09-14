-- [[ Setting options ]]
-- See `:help vim.o`

-- Set <space> as the leader key. See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader is used).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- :Explore -- tree-style netrw listing
vim.g.netrw_liststyle = 3

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set highlight on search
vim.o.hlsearch = true

-- Line numbers, relative to the cursor
vim.o.number = true
vim.o.relativenumber = true

-- Disable mouse mode
vim.o.mouse = ''

-- Save undo history
vim.o.undofile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'auto'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Indentation: 4 spaces, never a literal TAB
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Highlight the cursor's row and column
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- Let % jump between angle brackets too
vim.opt.matchpairs:append '<:>'

-- NOTE: the ColorColumn *highlight* lives in lua/plugins/ui.lua -- it has to be
-- applied after the colorscheme loads, or the colorscheme wipes it.
vim.o.colorcolumn = '100'
