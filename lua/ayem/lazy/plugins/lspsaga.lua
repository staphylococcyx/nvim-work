return {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    opts = {
        lightbulb = {
            enabled = false,
        },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
