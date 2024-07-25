return {
    { -- You can easily change to a different colorscheme.
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000, -- load before all other start plugins
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
            vim.cmd.colorscheme 'default'
            vim.o.colorcolumn = '80'
        end,
    },
}
