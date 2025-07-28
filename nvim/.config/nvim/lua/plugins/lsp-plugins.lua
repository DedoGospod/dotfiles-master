return {
    -- Mason
    {
        "williamboman/mason.nvim",
        lazy = false
    },

    -- Mason tool installer
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = "VeryLazy"
    },

    -- mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        lazy = true
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = "BufReadPre"
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        lazy = true,
        event = "InsertEnter"
    },

    -- Debugging
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        cmd = "DapLaunch"
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = true,
        cmd = "DapLaunch"
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        lazy = true
    },

    -- Linting
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = { "BufWritePost", "BufReadPost" }
    },

    -- Auto Pairs
    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = { "InsertEnter", "CmdlineLeave" }
    },

    -- Formatting
    {
        'stevearc/conform.nvim',
        lazy = true,
        event = { "BufWritePre" }
    },

    -- Utility/Other
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        lazy = true,
        event = "BufReadPre"
    },
}
