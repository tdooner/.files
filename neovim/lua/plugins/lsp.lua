return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      -- -------------------------------------------------------------
      -- nvim-cmp manages the autocomplete window functionality
      -- -------------------------------------------------------------
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        mapping = {
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-j>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item({behavior = 'insert'})
            else
              cmp.complete()
            end
          end),
          ['<C-k>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item({behavior = 'insert'})
            else
              cmp.complete()
            end
          end),
        },

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })

      -- -------------------------------------------------------------
      -- lsp-zero connects together lspconfig with nvim-cmp and
      -- possibly other plugins
      -- -------------------------------------------------------------
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({
          buffer = bufnr,
        })

        vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.implementation()<cr>')
      end)

      -- -------------------------------------------------------------
      -- mason is a package manager to install and configure LSPs
      -- -------------------------------------------------------------
      require('mason').setup({})
      require('mason-lspconfig').setup({
        -- see: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md (left column)
        ensure_installed = { "lua_ls", "tsserver", "terraformls", "ruby_lsp" },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          tsserver = function()
            require('lspconfig').tsserver.setup({
              on_attach = function(client, bufnr)
                -- fix imports (thanks: https://www.reddit.com/r/neovim/comments/192jxlv/comment/kh2zwdx/)
                vim.keymap.set('n', '<Leader>i', '<cmd>lua vim.lsp.buf.code_action({apply = true, context = {only = { "source.addMissingImports.ts" }}})<cr>')
              end
            })
          end,

          lua_ls = function()
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = {"vim"}
                  }
                }
              }
            })
          end,

          ruby_lsp = function()
            -- gem install ruby-lsp
            -- gem install ruby-lsp-rspec
            require('lspconfig').ruby_lsp.setup({
              cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") }
            })
          end,
        },
      })
    end,
    dependencies = {
      'hrsh7th/nvim-cmp',
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    }
  },
}
