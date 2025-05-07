-- Basic settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.showmode = false

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Sync clipboard between OS and Neovim 
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Load plugin manager
require("config.lazy")

-- Disable virtual_text since it's redundant due to lsp_lines
vim.diagnostic.config({
    virtual_text = false,  -- Disable inline text
    virtual_lines = true,  -- Enable virtual lines below code for diagnostics
})

-- Set colorscheme
vim.cmd.colorscheme("catppuccin")

-- Filetype detection for Hyprland
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
