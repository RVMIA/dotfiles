return {
    { -- You can easily change to a different colorscheme.
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            require('catppuccin').setup {
                flavour = 'auto',
                background = {
                    light = 'latte',
                    dark = 'mocha',
                },
                transparent_background = false,
                show_end_of_buffer = true,
            }
            vim.cmd.hi 'Comment gui=none'
            vim.cmd.colorscheme 'catppuccin'
            vim.o.colorcolumn = '80'
        end,
    },
}
