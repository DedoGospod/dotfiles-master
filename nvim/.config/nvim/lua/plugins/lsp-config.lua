return {
    -- Mason (must come before mason-lspconfig)
    { "williamboman/mason.nvim",                      lazy = false },

    -- Mason tool installer
    { "WhoIsSethDaniel/mason-tool-installer.nvim",    lazy = "VeryLazy" },

    -- mason-lspconfig (depends on mason.nvim)
    { "williamboman/mason-lspconfig.nvim",            dependencies = { "williamboman/mason.nvim" },                   lazy = true },

    -- LSP Configuration (depends on mason and mason-lspconfig)
    { "neovim/nvim-lspconfig",                        lazy = true,                                                    event = "BufReadPre" }, -- Lazy load on opening a buffer

    -- Completion (order matters for cmp)
    { "hrsh7th/nvim-cmp",                             lazy = true,                                                    event = "InsertEnter" },
    { "hrsh7th/cmp-buffer",                           dependencies = { "hrsh7th/nvim-cmp" },                          lazy = true,                              event = "InsertEnter" },
    { "hrsh7th/cmp-path",                             dependencies = { "hrsh7th/nvim-cmp" },                          lazy = true,                              event = "InsertEnter" },
    { "hrsh7th/cmp-cmdline",                          dependencies = { "hrsh7th/nvim-cmp" },                          lazy = true,                              event = "CmdlineEnter" },
    { "hrsh7th/cmp-vsnip",                            dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/vim-vsnip" },     lazy = true,                              event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp",                         dependencies = { "hrsh7th/nvim-cmp", "neovim/nvim-lspconfig" }, lazy = true,                              event = "InsertEnter" },
    { "saadparwaiz1/cmp_luasnip",                     dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },      lazy = true,                              event = "InsertEnter" },
    { 'onsails/lspkind.nvim' },

    -- Snippets
    { "hrsh7th/vim-vsnip",                            lazy = true,                                                    event = "InsertEnter" },
    { "L3MON4D3/LuaSnip",                             dependencies = { "rafamadriz/friendly-snippets" },              lazy = true,                              event = "InsertEnter" },

    -- Debugging
    { "mfussenegger/nvim-dap",                        lazy = true,                                                    cmd = "DapLaunch" },
    { "rcarriga/nvim-dap-ui",                         dependencies = { "mfussenegger/nvim-dap" },                     lazy = true,                              cmd = "DapLaunch" },
    { "jay-babu/mason-nvim-dap.nvim",                 dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap", },                                   lazy = true, },

    -- Linting
    { "mfussenegger/nvim-lint",                       lazy = true,                                                    event = { "BufWritePost", "BufReadPost" } },

    -- Auto Pairs
    { "windwp/nvim-autopairs",                        lazy = true,                                                    event = { "InsertEnter", "CmdlineLeave" } },

    -- Formatting
    { 'stevearc/conform.nvim',                        lazy = true,                                                    event = { "BufWritePre" } },

    -- Utility/Other
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", dependencies = { "neovim/nvim-lspconfig" },                     lazy = true,                              event = "BufReadPre" },

    -- Add any other plugins you have below
}
