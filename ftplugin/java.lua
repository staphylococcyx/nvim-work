local ok, jdtls = pcall(require, 'jdtls')
if not ok then
	return vim.notify('COULD NOT LOAD JDTLS', vim.log.levels.ERROR, { title = 'JDTLS' })
end

local jdtls_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local lombok_jar = jdtls_path .. '/lombok.jar'
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local function get_config_dir()
	-- Unlike some other programming languages (e.g. JavaScript)
	-- lua considers 0 truthy!
	if vim.fn.has 'linux' == 1 then
		return 'config_linux'
	elseif vim.fn.has 'mac' == 1 then
		return 'config_mac'
	else
		return 'config_win'
	end
end

local config = {
	cmd = {
		-- This sample path was tested on Cygwin, a "unix-like" Windows environment.
		-- Please contribute to this Wiki if this doesn't work for another Windows
		-- environment like [Git for Windows](https://gitforwindows.org/) or PowerShell.
		-- JDTLS currently needs Java 17 to work, but you can replace this line with "java"
		-- if Java 17 is on your PATH.
		'C:/Program Files/Java/jdk-24/bin/java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1G',
		'-javaagent:' .. lombok_jar,
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED',
		'-jar',
		launcher_jar,
		'-configuration',
		vim.fs.normalize(jdtls_path .. '/' .. get_config_dir()),
		'-data',
		vim.fn.expand '~/.cache/jdtls-workspace/' .. workspace_dir,
	},
	-- settings = {
	-- 	['java.format.settings.url'] = vim.fn.expand '~/formatter.xml',
	-- },
	root_dir = vim.fs.dirname(
		vim.fs.find({ 'pom.xml', '.git', 'mvnw', 'gradlew' }, { upward = true })[1]
	),
	init_options = {
		-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities#extended-client-capabilities
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
	on_attach = function (_, bufnr)
		local keymap = vim.keymap
		local opts = { silent = true, buffer = bufnr }
		keymap.set(
			'n',
			'<leader>lo',
			jdtls.organize_imports,
			{ desc = 'Organize imports', buffer = bufnr }
		)
		-- Should 'd' be reserved for debug?
		keymap.set('n', '<leader>tf', jdtls.test_class, opts)
		keymap.set('n', '<leader>tn', jdtls.test_nearest_method, opts)
		-- vim.keymap.set('n', '<leader>rv', jdtls.extract_variable_all, { desc = 'Extract variable', buffer = bufnr })
		-- vim.keymap.set('v', '<leader>rm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
		-- { desc = 'Extract method', buffer = bufnr })
		-- keymap.set('n', '<leader>rc', jdtls.extract_constant, { desc = 'Extract constant', buffer = bufnr })
		keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		keymap.set('n', '<space>dm', vim.diagnostic.open_float, opts)
		keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	end,
}

jdtls.start_or_attach(config)

