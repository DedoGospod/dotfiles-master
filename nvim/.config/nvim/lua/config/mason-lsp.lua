-- Mason setup to manage both LSPs and formatters
require("mason").setup({
  ensure_installed = {
    -- Language Servers
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
        -- "gofmt", (find alternative, mason doesnt have this)
	-- zigfmt (find alternative, mason doesnt have this)
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
              workspace = { checkThirdParty = false }, -- Don't check libraries you didn't write
              telemetry = { enable = false }, -- Opt-out of telemetry
            },
          },
        }
      elseif server_name == "basedpyright" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- Or "strict" for more rigorous checking
                diagnosticMode = "openFilesOnly", -- Or "workspace" to check all project files
                useLibraryCodeForTypes = true, -- Improve type inference
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
              cargo = {
                allFeatures = true, -- Enable all features by default
              },
              procMacro = {
                enable = true, -- Enable procedural macro support
              },
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
              staticcheck = true, -- Enable staticcheck
              usePlaceholders = true, -- Add placeholders for function arguments
            },
          },
        }
      elseif server_name == "bashls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            bashIde = {
              globExcludePatterns = { "**/node_modules/**" }, -- Example exclusion
            },
          },
        }
      elseif server_name == "html" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            html = {
              format = {
                enable = true,
                indentInnerHtml = true,
                wrapLineLength = 120,
              },
            },
          },
        }
      elseif server_name == "zls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          -- Zig doesn't have many common LSP settings yet, but i might add a formatter config here later
        }
      elseif server_name == "ts_ls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            typescript = {
              tsdk = {
                enable = true,
                autoSearchSystemTs = true,
              },
            },
            javascript = {
              tsdk = {
                enable = true,
                autoSearchSystemTs = true,
              },
            },
            format = {
              enable = true,
              semicolons = "always",
              singleQuote = true,
            },
          },
        }
      elseif server_name == "clangd" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          -- Might want to configure compileCommands.json path or other clangd flags here
          -- settings = {
          --    ["clangd"] = {
          --      arguments = { "--compile-commands-dir=build" },
          --    },
          -- },
        }
      else
        lspconfig[server_name].setup {
          capabilities = capabilities, -- Still apply default capabilities to other servers
        }
      end
    end,
  },
})
