return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				disable = { "latex" },
			},
			indent = { enable = true },
			autotag = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"css",
				"gitignore",
				"html",
				"json",
				"javascript",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"ron",
				"vim",
				"vimdoc",
				"yaml",
			},
		})
	end,
}
