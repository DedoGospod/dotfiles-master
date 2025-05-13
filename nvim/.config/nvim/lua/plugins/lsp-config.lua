return {
  -- Mason (must come before mason-lspconfig)
  { "williamboman/mason.nvim" },

  -- mason-lspconfig (depends on mason.nvim)
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },

  -- LSP Configuration (depends on mason and mason-lspconfig)
  { "neovim/nvim-lspconfig" },

  -- Completion (order matters for cmp)
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer", dependencies = { "hrsh7th/nvim-cmp" } },
  { "hrsh7th/cmp-path", dependencies = { "hrsh7th/nvim-cmp" } },
  { "hrsh7th/cmp-cmdline", dependencies = { "hrsh7th/nvim-cmp" } },
  { "hrsh7th/cmp-vsnip", dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/vim-vsnip" } },
  { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp", "neovim/nvim-lspconfig" } },
  { "saadparwaiz1/cmp_luasnip", dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" } }, -- Corrected inclusion

  -- Snippets
  { "hrsh7th/vim-vsnip" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets", dependencies = { "L3MON4D3/LuaSnip" } },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

  -- Testing
  { "nvim-neotest/nvim-nio" }, -- Assuming this is the core neotest plugin

  -- Linting
  { "mfussenegger/nvim-lint" },

  -- Auto Pairs
  { "windwp/nvim-autopairs" },

  -- Formatting
  { 'stevearc/conform.nvim' },

  -- Utility/Other
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", dependencies = { "neovim/nvim-lspconfig" } },

  -- Add any other plugins you have below
}
