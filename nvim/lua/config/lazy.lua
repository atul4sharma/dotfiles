-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Every file under lua/plugins/ is imported automatically; each returns a spec
-- table carrying both the plugin declaration and its configuration.
-- See: https://github.com/folke/lazy.nvim#-structuring-your-plugins
require('lazy').setup({
  { import = 'plugins' },
}, {})
