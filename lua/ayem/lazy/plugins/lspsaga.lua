return {
	'nvimdev/lspsaga.nvim',
	event = 'LspAttach',
	opts = {
		lightbulb = {
			enable = false,
		},
	},
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
