-- ██╗███╗   ██╗██╗████████╗
-- ██║████╗  ██║██║╚══██╔══╝
-- ██║██╔██╗ ██║██║   ██║   
-- ██║██║╚██╗██║██║   ██║   
-- ██║██║ ╚████║██║   ██║   
-- ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   
-- Neovim Configuration File

-- ======================
-- 1. Package Management
-- ======================

-- Set base46 cache path (for theme management)
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

-- Set leader key to space
vim.g.mapleader = " "

-- Bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Import lazy.nvim configuration
local lazy_config = require("configs.lazy")

-- ======================
-- 2. Plugin Configuration
-- ======================

-- Initialize plugins with lazy.nvim
require("lazy").setup({
  -- Core NvChad configuration
  {
    "NvChad/NvChad",
    lazy = false,        -- Load immediately
    branch = "v2.5",     -- Specific version branch
    import = "nvchad.plugins",  -- Import NvChad defaults
  },

  -- User custom plugins
  { import = "plugins" }, 
}, lazy_config)

-- ======================
-- 3. Theme Initialization
-- ======================

-- Load base46 default theme components
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- ======================
-- 4. Configuration Files
-- ======================

-- Load core Neovim options
require("options")

-- Schedule mappings to load after plugins
vim.schedule(function()
  require("mappings")
end)

-- ======================
-- 5. Filetype Detection
-- ======================

-- Add custom syntax for Hyprland config files
vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",  -- Recognize *.conf in hypr directories
  },
}
