-- Plugin setup with lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  },
  checker = { enabled = true },
})

-- Require configs
require("config.keymaps")    -- require keymaps
require("config.mason-lsp")  -- require mason-lsp config

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

-- Completion (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
mapping = cmp.mapping.preset.insert({
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
}),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
    },
})

-- nvim-cmp autopairs (bracket/parenthesis completion)
local npairs = require('nvim-autopairs')
npairs.setup({
  check_ts = true,
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- nvim-treesitter configuration
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "markdown",
    "markdown_inline", "bash", "lua", "vim", "dockerfile", "c", "c_sharp", "cpp",
    "rust", "go", "hyprlang", "zig"
  },
})

-- nvim-tree configuration
require("nvim-tree").setup {
  open_on_tab = false,
  update_focused_file = { enable = true, update_cwd = true },
}

-- Debugger UI for nvim-dap (shows variables, stacks, etc.)
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end  -- Auto-open on debug start
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end -- Auto-close on exit

-- Lualine status bar
require("lualine").setup {
  options = { theme = 'catppuccin' },
}

-- ( DAP, LINTERS, AND FORMATTER HAVE NOT BEEN CONFIGURED YET, REMEMBER TO DO 
