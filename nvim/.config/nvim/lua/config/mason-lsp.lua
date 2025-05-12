-- Mason setup for automatic LSP configuration
require("mason").setup()

-- LSP Configuration
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup({
  ensure_installed = { "basedpyright", "rust_analyzer", "gopls", "bashls", "html", "zls", "ts_ls", "clangd", "lua_ls" },
  handlers = {
    function(server_name)
      if server_name == "lua_ls" then
        lspconfig[server_name].setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } },
            },
          },
        }
      else
        lspconfig[server_name].setup {
          capabilities = capabilities, -- Still apply default capabilities to other servers
        }
      end
    end,
  },
})
