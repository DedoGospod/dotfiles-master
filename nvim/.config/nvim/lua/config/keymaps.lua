-- ----------------
--   KEYMAPPINGS
-- ----------------

-- Key mappings for telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })

-- Nvim-tree
vim.keymap.set('n', '<C-n>', function() require('nvim-tree.api').tree.toggle() end, { desc = 'Toggle file tree' })

-- Compiler.nvim keymappings
vim.api.nvim_set_keymap('n', '<F9>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })           -- Open compiler
vim.api.nvim_set_keymap('n', '<F10>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true }) -- Toggle compiler results

-- trouble.nvim keymaps
keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
}

-- Import the Comment.nvim API
local CommentAPI = require('Comment.api')
vim.keymap.set('n', '<C-c>', function() CommentAPI.toggle.linewise.current() end, { desc = 'Toggle line comment' })

-- Jump to end of line
vim.api.nvim_set_keymap('i', '<C-a>', '<End>', { silent = true, noremap = true }) -- ctrl + a (while in insert mode)
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { silent = true, noremap = true }) -- ctrl + e (while in insert mode)

-- Toggle a floating terminal
vim.keymap.set('n', '<C-q>', '<cmd>ToggleTerm<cr>', { desc = 'Toggle floating terminal' })
vim.keymap.set('n', '<Esc>', '<C-q>', { desc = 'Exit terminal mode' }) -- Important!
