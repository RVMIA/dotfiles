return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
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
        end,
    },
}
