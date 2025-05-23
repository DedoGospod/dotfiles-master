-- Mason setup to manage both LSPs and formatters
require("mason").setup({})
require("mason-tool-installer").setup({
	ensure_installed = {
		-- LSP Servers
		"basedpyright",
		"rust_analyzer",
		"gopls",
		"bashls",
		"html",
		"zls",
		"ts_ls",
		"clangd",
		"lua_ls",
		-- Formatters
		"stylua",
		"black",
		"isort",
		"prettier",
		"shfmt",
		"clang-format",
		"crlfmt",
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
			else
				lspconfig[server_name].setup { capabilities = capabilities }
			end
		end,
	},
})
