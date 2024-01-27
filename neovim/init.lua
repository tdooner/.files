-- --------------------------------------------------------------------------
-- Configuration
-- --------------------------------------------------------------------------
vim.g.mapleader = ','
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.wildignore:append{
  '*/node_modules/*','*/vendor/*','*/env/*','*/bower_components/*','*.pyc','doc/*','*/tmp/*','target/*','coverage/*'
}

-- nvim-tree options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- --------------------------------------------------------------------------
-- Install Packages w/lazy.nvim
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
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd[[colorscheme tokyonight]]
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set('n', '<Leader><Leader>', ':NvimTreeFindFile<CR>')
    end,
  },
  {
  "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup {}
      -- TODO: Eventually configure this to just fix imports automatically on save or something.
      vim.keymap.set('n', '<Leader>i', ':TSToolsAddMissingImports<CR>')
    end,
  }
}, opts)
