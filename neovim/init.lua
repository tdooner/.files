vim.g.mapleader = ','

-- --------------------------------------------------------------------------
-- Lazy Package Manager
-- --------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Command-T
require("lazy").setup({
  {
    'wincent/command-t',
    build = 'cd lua/wincent/commandt/lib && make',
    init = function()
      vim.g.CommandTPreferredImplementation = 'lua'
    end,
    config = function()
      require('wincent.commandt').setup()
      vim.keymap.set('n', '<Leader>b', '<Plug>(CommandTBuffer)')
      vim.keymap.set('n', '<Leader>j', '<Plug>(CommandTJump)')
      vim.keymap.set('n', '<Leader>t', '<Plug>(CommandT)')
    end,
  },
}, opts)
