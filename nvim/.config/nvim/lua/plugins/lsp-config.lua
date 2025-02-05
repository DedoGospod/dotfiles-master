return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
	    "williamboman/mason-lspconfig.nvim",
	    "mfussenegger/nvim-dap",
	    "rcarriga/nvim-dap-ui",
	    "nvim-neotest/nvim-nio",
	    "mhartington/formatter.nvim",
	    "mfussenegger/nvim-lint",
        },
    },
}
