-- Mason setup to manage both LSPs and formatters
require("mason").setup({})
require("mason-tool-installer").setup({
    ensure_installed = {
        -- LSP Servers
        "basedpyright",              -- python
        "rust_analyzer",             -- rust
        "gopls",                     -- go
        "bashls",                    -- bash
        "html",                      -- html
        "zls",                       -- zig
        "ts_ls",                     -- typescript/javascript
        "clangd",                    -- c/cpp
        "lua_ls",                    -- lua
        "csharp-language-server"     -- C sharp
        -- Formatters
        "black",                     -- python
        "isort",                     -- python
        "crlfmt",                    -- Go
        "shfmt",                     -- sh, bash, ksh, zsh
        "prettier",                  -- JavaScript, TypeScript, Flow, JSX, JSON, CSS, SCSS, Less, HTML, Vue, Angular, GraphQL, Markdown, YAML
        "clang-format",              -- C, C++, Objective-C, Objective-C++, Java, JavaScript, TypeScript, C#
        "stylua",                    -- lua

        -- Linters
        "pylint",                    -- python
        "golangci-lint",             -- GO
        "shellcheck",                -- bash
        "htmlhint",                  -- html
        "eslint_d",                  -- ts_ls
        -- "cpplint",                   -- C/C++
        "luacheck",                  -- lua
        -- DAPs
        "debugpy",                   -- Python (for basedpyright)
        "codelldb",                  -- Rust (for rust_analyzer) and Zig (for zls) and C/C++ (for clangd)
        "delve",                     -- Go (for gopls)
        "js-debug-adapter",          -- TypeScript/JavaScript (for ts_ls)
        "local-lua-debugger-vscode", -- Lua (for lua_ls)
    },
    auto_update = true,
})

-- LSP Configuration
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Define your custom clangd setup
lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--clang-tidy",
        "--clang-tidy-checks=*",
    },
    -- Add any other clangd specific settings here
    -- },
})

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
