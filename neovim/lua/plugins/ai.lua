return {
  -- Add inline completions via virtualtext
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        notify = 'debug',
        after_cursor_filter_length = 30,
        virtualtext = {
          auto_trigger_ft = { 'ruby' },
          keymap = {
            -- accept whole completion
            accept = '<Tab>',
            -- accept one line
            accept_line = '<C-3>',
            -- accept n lines (prompts for number)
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<M-j>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<M-k>',
            dismiss = '<M-q>',
          }
        },
        provider_options = {
          codestral = {
            model = 'codestral-latest',
            end_point = 'https://codestral.mistral.ai/v1/fim/completions',
            api_key = 'CODESTRAL_API_KEY',
            stream = true,
          },
          openai_fim_compatible = {
            model = 'Qwen/Qwen2.5-Coder-32B-Instruct',
            end_point = 'https://api.together.xyz/v1/chat/completions',
            name = 'TogetherAI',
            -- system = "see [Prompt] section for the default value",
            -- few_shots = "see [Prompt] section for the default value",
            -- chat_input = "See [Prompt Section for default value]",
            -- stream = true,
            api_key = 'TOGETHER_API_KEY',
            optional = {
              -- pass any additional parameters you want to send to OpenAI request,
              -- e.g.
              stop = { '\n\n' },
              max_tokens = 512,
              -- top_p = 0.9,
            }
          }
        }
      }
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-treesitter/nvim-treesitter",
        -- Verify with :TSInstallInfo
        config = function()
          local configs = require("nvim-treesitter.configs")
          configs.setup({
            ensure_installed = {"ruby", "markdown", "yaml"}
          })
        end
      }
    },
    log_level = "DEBUG",
    config = true,
    opts = {
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            model = "qwen2.5-coder:7b"
          })
        end
      },
      -- display = {
      --   chat = {
      --     show_settings = true
      --   }
      -- },
      strategies = {
        inline = {
          adapter = "ollama"
        },
        chat = {
          adapter = "ollama"
        }
      }
    }
  }
}
