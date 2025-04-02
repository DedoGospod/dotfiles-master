-- Basic settings
vim.g.mapleader = ' '       -- Set global leader key to space for custom mappings
vim.g.maplocalleader = ' '  -- Set local leader key to space for buffer-specific mappings
vim.opt.number = true       -- Show line numbers
vim.opt.mouse = 'a'         -- Enable mouse support in all modes
vim.opt.breakindent = true  -- Preserve indentation when wrapping text
vim.opt.undofile = true     -- Maintain undo history between sessions
vim.opt.signcolumn = 'yes'  -- Always show sign column (for git/LSP markers)
vim.opt.updatetime = 250    -- Time (ms) for CursorHold events and swap file writes
vim.opt.timeoutlen = 300    -- Time (ms) to wait for mapped key sequences
vim.opt.inccommand = 'split'-- Show live command preview in split window
vim.opt.cursorline = true   -- Highlight current line
vim.opt.showmode = false    -- Hide mode indicator (since it's in statusline)

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup with lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  },
  checker = { enabled = true },
})

-- Key mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<C-n>', function() require('nvim-tree.api').tree.toggle() end, { desc = 'Toggle file tree' })

-- Telescope configuration
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
  },
  pickers = {
    find_files = { hidden = true },
  },
}

-- LSP setup
local lspconfig = require('lspconfig')
lspconfig.basedpyright.setup {} -- Python
lspconfig.gopls.setup {} -- Go
lspconfig.rust_analyzer.setup {} -- Rust
lspconfig.lua_ls.setup { -- Lua
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
}

-- Mason for automatic LSP installation
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "basedpyright", "rust_analyzer", "lua_ls" },
})

-- Completion (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
mapping = cmp.mapping.preset.insert({
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})

-- Lualine status bar
require("lualine").setup {
  options = { theme = 'catppuccin' },
}
