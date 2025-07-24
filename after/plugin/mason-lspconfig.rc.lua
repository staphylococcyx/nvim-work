local ok, mlsp = pcall(require, "mason-lspconfig")
if not ok then
	return vim.notify("COULD NOT LOAD MASON-LSPCONFIG", vim.log.levels.ERROR, { title = "MASON-LSPCONFIG" })
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
	return vim.notify("COULD NOT LOAD CMP_NVIM_LSP", vim.log.levels.ERROR, { title = "CMP_NVIM_LSP" })
end

local on_attach_ok, on_attach = pcall(require, "ayem.lspconfig.utils.on_attach")
if not on_attach_ok then
	return vim.notify("COULD NOT LOAD ON_ATTACH", vim.log.levels.ERROR, { title = "ON_ATTACH" })
end

local ensure_installed = {
	"docker_compose_language_service",
	"dockerls",
	"intelephense",
	"jdtls",
	"lua_ls",
}

local excluded_servers = { "jdtls" }

mlsp.setup({
	ensure_installed = ensure_installed,
	automatic_enable = false,
})

local server_opts = {
	on_attach = on_attach,
	capabilities = cmp_nvim_lsp.default_capabilities(),
}

vim.schedule(function()
	for _, server in ipairs(mlsp.get_installed_servers()) do
		if not vim.tbl_contains(excluded_servers, server) then
			local server_ok, opts = pcall(require, "ayem.lspconfig.servers." .. server)
			if server_ok then
				server_opts = vim.tbl_deep_extend("force", opts, server_opts)
			end

			vim.lsp.config(string.lower(server), server_opts)
			vim.lsp.enable(server)
		end
	end
end)
