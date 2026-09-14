-- lua/config/  settings, keymaps, autocmds, lazy bootstrap
-- lua/plugins/ one file per plugin group: spec + config
-- :Mason (LSP/DAP installer)  :Telescope keymaps

require 'config.options' -- first: sets mapleader before lazy loads plugins
require 'config.lazy'
require 'config.keymaps'
require 'config.autocmds'
