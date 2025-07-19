-- ----------------
--   KEYMAPPINGS
-- ----------------

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })

-- Neotree
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {
    noremap = true,
    silent = true,
    desc = 'Toggle Neo-tree'
})

vim.keymap.set('n', '<C-o>', ':Neotree focus<CR>', {
    noremap = true,
    silent = true,
    desc = 'Focus Neo-tree'
})

-- Compiler.nvim
vim.keymap.set('n', '<F9>', "<cmd>CompilerOpen<cr>", { desc = 'Open compiler' })
vim.keymap.set('n', '<F10>', "<cmd>CompilerToggleResults<cr>", { desc = 'Toggle compiler results' })

-- trouble.nvim
local trouble_keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
}

for _, mapping in ipairs(trouble_keys) do
    vim.keymap.set('n', mapping[1], mapping[2], { desc = mapping.desc })
end

-- Comment.nvim
local CommentAPI = require('Comment.api')
vim.keymap.set('n', '<C-c>', function() CommentAPI.toggle.linewise.current() end, { desc = 'Toggle line comment' })

-- Jump to end of line
vim.api.nvim_set_keymap('i', '<C-a>', '<End>', { silent = true, noremap = true }) -- ctrl + a (while in insert mode)
vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { silent = true, noremap = true }) -- ctrl + e (while in insert mode)

-- F-term
vim.keymap.set('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()
