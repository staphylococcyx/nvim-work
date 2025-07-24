local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return vim.notify(
		"COULD NOT LOAD NVIM-TREESITTER.CONFIGS",
		vim.log.levels.ERROR,
		{ title = "NVIM-TREESITTER.CONFIGS" }
	)
end

local ok_install, install = pcall(require, "nvim-treesitter.install")
if not ok_install then
	return vim.notify(
		"COULD NOT LOAD NVIM-TREESITTER.INSTALL",
		vim.log.levels.ERROR,
		{ title = "NVIM-TREESITTER.INSTALL" }
	)
end

install.prefer_git = vim.fn.has("win32") == 1

local ensure_installed = {
	"comment",
	"css",
	"dockerfile",
	"editorconfig",
	"gitattributes",
	"gitignore",
	"html",
	"ini",
	"java",
	"javadoc",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"lua",
	"luadoc",
	"luap",
	"php",
	"phpdoc",
	"properties",
	"rust",
	"toml",
	"tsx",
	"twig",
	"typescript",
	"vimdoc",
	"xml",
	"yaml",
}

configs.setup({
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = ensure_installed,

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,

	highlight = {
		enable = true,
		disable = function(_, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local stats_ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if stats_ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},

	indent = { enable = true },
})
