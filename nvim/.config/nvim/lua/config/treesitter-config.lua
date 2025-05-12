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
