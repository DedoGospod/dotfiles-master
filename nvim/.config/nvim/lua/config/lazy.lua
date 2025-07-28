-- Plugin setup with lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    },
    checker = { enabled = true },
})

-- Require configs
require("config.keymaps")     -- Keymaps
require("config.lsp")         -- Lsp config

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

-- LSP lines setup
require("lsp_lines").setup()

-- Nvim autopairs
require('nvim-autopairs').setup()
