return function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

	-- Buffer local mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local opts = { buffer = bufnr }
	local keymap = vim.keymap
	keymap.set({ 'n', 'v' }, '<leader>ca', '<CMD>Lspsaga code_action<CR>', opts)
	keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	keymap.set('n', 'gd', '<CMD>Lspsaga goto_definition<CR>', opts)
	keymap.set('n', 'K', '<CMD>Lspsaga hover_doc<CR>', opts)
	keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
	keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
	keymap.set('n', '<space>dm', '<CMD>Lspsaga show_line_diagnostics<CR>', opts)
	keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
	keymap.set('n', '<space>rn', '<CMD>Lspsaga rename<CR>', opts)
	-- keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
	keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	keymap.set('n', '<leader>ca', '<CMD>Lspsaga code_action<CR>', opts)
end
