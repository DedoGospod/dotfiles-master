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
        ['<C-p>'] = cmp.mapping.select_next_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = {
        { name = 'luasnip',  max_item_count = 3 },
        { name = 'nvim_lsp', max_item_count = 3 },
        { name = 'buffer',   max_item_count = 3 },
        { name = 'path',     max_item_count = 3 },
        { name = 'cmdline',  max_item_count = 5 },
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
