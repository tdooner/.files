return {
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
      vim.keymap.set('n', '<Leader>t', '<Plug>(CommandTRipgrep)')
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
      vim.keymap.set('n', 'gf', ':TSToolsGoToSourceDefinition<CR>')
    end,
    settings = {
    }
  },
  {
    "duane9/nvim-rg"
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre"
      })
      vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word"
      })
      vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word"
      })
      vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file"
      })
    end,
  }
}
