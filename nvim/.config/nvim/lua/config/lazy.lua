-- [SETTINGS]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.inccommand = 'split'
vim.opt.cursorline = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
  },
  checker = { enabled = true },
})



-- [KEYMAPPINGS]

-- Telescope 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })



-- [CONFIGURATIONS]


-- NVIM TREE 
vim.keymap.set('n', '<C-n>', function()
  require('nvim-tree.api').tree.toggle()
end, { desc = 'Toggle file tree' })


-- TELESCOPE
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
    find_files = {
      hidden = true,
    },
  },
}

-- LSP Setup with nvim-lspconfig
local lspconfig = require('lspconfig')

-- Example: Python (pyright)
lspconfig.basedpyright.setup {}

-- Example: JavaScript and TypeScript (tsserver)
--lspconfig.tsserver.setup {} (This isnt maintained)

-- Example: Go (gopls)
lspconfig.gopls.setup {}

-- Example: Rust (rust_analyzer)
lspconfig.rust_analyzer.setup {}

-- Example: Lua (sumneko_lua)
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },  -- to let Lua know that `vim` is a global variable
      },
    },
  },
}

-- Automatically install missing servers with mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "basedpyright", "rust_analyzer", }, -- Add more as needed
})

-- Completion setup (nvim-cmp)
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})

-- Trouble plugin for LSP diagnostics
require("trouble").setup()

-- Lualine setup for status line
require("lualine").setup {
  options = {
    theme = 'catppuccin',
  },
}
