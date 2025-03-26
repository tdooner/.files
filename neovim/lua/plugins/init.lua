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
          git_ignored = true
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

          -- Open help
          vim.keymap.set('n', '?', function() vim.cmd('help nvim-tree-quickstart-help') end, opts('Open help'))
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
      require('spectre').setup({
        highlight = {
          search = "DiffDelete",
          replace = "DiffAdd"
        }
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      -- see: https://github.com/alexghergh/nvim-tmux-navigation?tab=readme-ov-file#neovim
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- Verify with :TSInstallInfo
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "ruby", "markdown", "yaml", "hcl" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true
        }
      })
    end
  }
}
