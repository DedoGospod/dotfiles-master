-- Mason setup to manage both LSPs and formatters
require("mason").setup({
  ensure_installed = {
    "basedpyright",
    "rust_analyzer",
    "gopls",
    "bashls",
    "html",
    "zls",
    "ts_ls",
    "clangd",
    "lua_ls",
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua",
    "black",
    "isort",
    "rustfmt",
    "prettier",
    "shfmt",
    "clang-format",
    -- "gofmt", (find alternative)
    -- "zigfmt", (find alternative)
  },
})

-- LSP Configuration
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      if server_name == "lua_ls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              completion = { callSnippet = "Replace" },
              hint = { enable = true },
            },
          },
        }
      elseif server_name == "basedpyright" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        }
      elseif server_name == "rust_analyzer" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = true,
              cargo = { allFeatures = true },
              procMacro = { enable = true },
            },
          },
        }
      elseif server_name == "gopls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                unreachable = true,
                nilness = true,
                shadow = true,
                unusedwrite = true,
              },
              staticcheck = true,
              usePlaceholders = true,
              gofumpt = true,
              buildFlags = { "-tags", "integration" },
            },
          },
        }
      elseif server_name == "bashls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            bashIde = { globExcludePatterns = { "**/node_modules/**" } },
          },
        }
      elseif server_name == "html" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            html = {
              format = { enable = true, indentInnerHtml = true, wrapLineLength = 120 },
            },
          },
        }
      elseif server_name == "zls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          -- Add Zig specific settings if needed later
        }
      elseif server_name == "ts_ls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            typescript = { tsdk = { enable = true, autoSearchSystemTs = true } },
            javascript = { tsdk = { enable = true, autoSearchSystemTs = true } },
            format = { enable = true, semicolons = "always", singleQuote = true },
          },
        }
      elseif server_name == "clangd" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          -- Configure compileCommands.json path or other clangd flags if needed
          -- settings = {
          --   ["clangd"] = {
          --     arguments = { "--compile-commands-dir=build" },
          --   },
          -- },
        }
      else
        lspconfig[server_name].setup { capabilities = capabilities }
      end
    end,
  },
})
