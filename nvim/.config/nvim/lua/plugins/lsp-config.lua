return {
    {
        "williamboman/mason.nvim",
        config = function()
            -- === nvim-lint setup ===
            local lint = require("lint")
            lint.linters_by_ft = {
                sh = { "shellcheck" },
                bashrc = { "shellcheck" },
                env = { "shellcheck" },
            }

            -- Auto-run linting on save and file open
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-lint",
            "mhartington/formatter.nvim",
            "windwp/nvim-autopairs",
	    "hrsh7th/cmp-nvim-autopairs",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
    },

    -- lsp_lines.nvim
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    },
}
