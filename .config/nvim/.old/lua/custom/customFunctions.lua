Sizes = function()
    local fontString = vim.api.nvim_get_option 'guifont'
    local currentFont, size = fontString:match '([^:]+):h(%d+)'
    local defaultSize = size

    vim.keymap.set('n', '<C-=>', function()
        size = size + 1
        vim.opt.guifont = currentFont .. ':h' .. size
    end)
    vim.keymap.set('n', '<C-->', function()
        size = size - 1
        vim.opt.guifont = currentFont .. ':h' .. size
    end)
    vim.keymap.set('n', '<C-0>', function()
        size = defaultSize
        vim.opt.guifont = currentFont .. ':h' .. size
    end)
end

Sizes()
