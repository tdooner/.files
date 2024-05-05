-- --------------------------------------------------------------------------
-- Configuration
-- --------------------------------------------------------------------------
vim.g.mapleader = ','
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.number = true
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

require("lazy").setup("plugins")
