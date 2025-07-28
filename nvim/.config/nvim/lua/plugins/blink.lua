return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },

  version = '1.*',
  ---@module 'blink.cmp'
  opts = {
    keymap = { preset = 'default',
      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = true } },
sources = {
      default = { 'snippets', 'lsp', 'path', 'buffer', 'cmdline' },
      -- Configure individual source priorities using score_offset
      providers = {
        snippets = {
          score_offset = 100,
          max_items = 3,
        },
        lsp = {
          score_offset = 50,
          max_items = 3
        },
        path = {
          score_offset = 20,
          max_items = 3
        },
        buffer = {
          score_offset = 0,
          max_items = 3,
        },
        cmdline = {
          score_offset = -10,
          max_items = 5,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
