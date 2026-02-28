return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			tex = { "latexindent" },
			typst = { "typstyle" },
		},
		format_on_save = { timeout_ms = 10000 },
	},
}
