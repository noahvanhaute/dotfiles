return {
	cmd = { "ltex-ls-plus" },
	filetypes = { "bib", "tex" },
	on_attach = function()
		require("ltex_extra").setup({
			path = (vim.fn.stdpath("config")) .. "/ltex_extra",
		})
	end,
	root_markers = { { ".git" } },
	settings = {
		ltex = {
			enabled = { "latex", "tex" },
			latex = {
				commands = {
					["\\bamadegree{}"] = "ignore",
					["\\ce{}"] = "dummy",
					["\\lstinputlisting[]{}"] = "ignore",
					["\\pgfdeclarelayer{}"] = "ignore",
					["\\pgfplotsset{}"] = "ignore",
					["\\pgfsetlayers{}"] = "ignore",
					["\\qtyrange[]{}{}"] = "dummy",
					["\\qty{}{}"] = "dummy",
					["\\setmainfont[]{}"] = "ignore",
					["\\setmathfont[]{}"] = "ignore",
					["\\setmonofont[]{}"] = "ignore",
					["\\setsansfont[]{}"] = "ignore",
					["\\texorpdfstring{}{}"] = "dummy",
					["\\unit{}"] = "ignore",
					["\\usecolortheme{}"] = "ignore",
					["\\usefonttheme{}"] = "ignore",
					["\\useinnertheme{}"] = "ignore",
					["\\useoutertheme{}"] = "ignore",
					["\\UseTblrLibrary{}"] = "ignore",
					["\\usetheme{}"] = "ignore",
				},
			},
		},
	},
}
