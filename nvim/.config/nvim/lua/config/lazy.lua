-- Plugin setup with lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    },
    checker = { enabled = true },
})

-- Require configs
require("config.keymaps")   -- Keymaps
require("config.mason-lsp") -- Mason/lsp config

-- Neotree configuration
require('neo-tree').setup({
    window = {
        auto_expand_width = true,
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
        },
    },
})

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
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- "smart_case", "ignore_case" or "respect_case"
        }
    }
}

-- Telescope fzf integration
require('telescope').load_extension('fzf')

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
-- Lualine status bar
require("lualine").setup {
    options = { theme = 'catppuccin' },
}

-- Snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- Completion (nvim-cmp)
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(), -- This is your current mapping
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = {
        { name = 'luasnip',  max_item_count = 3 },
        { name = 'nvim_lsp', max_item_count = 3 },
        { name = 'buffer',   max_item_count = 3 },
        { name = 'path',     max_item_count = 3 },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = require('lspkind').format,
    },
})

-- nvim-cmp autopairs (bracket/parenthesis completion)
local npairs = require('nvim-autopairs')
npairs.setup({
    check_ts = true,
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- LSP lines setup
require("lsp_lines").setup()


-- Conform formatter setup
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        go = { "gofmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        html = { "prettier" },
        zig = { "zigfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },
    },
})

-- nvim-lint setup
local lint = require("lint")
lint.linters_by_ft = {
    sh = { "shellcheck" },
    bashrc = { "shellcheck" },
    env = { "shellcheck" },
}

-- ( DAP AND LINTERS NOT CONFIGURED YET, REMEMBER TO DO SO )
