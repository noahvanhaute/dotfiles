return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"latexindent",
				"ltex-ls-plus",
				"lua-language-server",
				"stylua",
				"tinymist",
				"tree-sitter-cli",
				"typstyle",
			},
		})
	end,
}
