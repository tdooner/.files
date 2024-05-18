return {
  {
    'wincent/command-t',
    build = 'cd lua/wincent/commandt/lib && make',
    init = function()
      vim.g.CommandTPreferredImplementation = 'lua'
    end,
    config = function()
      require('wincent.commandt').setup({
        ignore_case = true,
        smart_case = true
      })
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
      require("nvim-tree").setup({
        filters = {
          git_ignored = false
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          api.config.mappings.default_on_attach(bufnr)

          -- Split with vertical bar with Ctrl+Bar (actually backslash since shift isn't pressed)
          vim.keymap.set('n', '<C-\\>', api.node.open.vertical, opts('Open: Split Vertically'))
          -- Split with horizontal bar with Ctrl-Dash (doesn't work on windows)
          vim.keymap.set('n', '<C-->', api.node.open.horizontal, opts('Open: Split Horizontally'))
        end,
      })
      vim.keymap.set('n', '<Leader><Leader>', ':NvimTreeFindFile!<CR>')
    end,
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
    dependencies = { "nvim-lua/plenary.nvim" }
  }
}
