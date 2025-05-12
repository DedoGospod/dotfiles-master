-- Plugin setup with lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  },
  checker = { enabled = true },
})

-- Require configs
require("config.keymaps")           -- Keymaps
require("config.mason-lsp")         -- Mason-lsp config
require("config.telescope-config")  -- Telescope config
require("config.cmp-config")        -- Cmp config
require("config.treesitter-config") -- Treesitter config
require("config.nvim-tree-config")  -- Nvim-tree config
require("config.lualine-config")    -- Lualine config

-- ( DAP, LINTERS, AND FORMATTER HAVE NOT BEEN CONFIGURED YET, REMEMBER TO DO SO )
