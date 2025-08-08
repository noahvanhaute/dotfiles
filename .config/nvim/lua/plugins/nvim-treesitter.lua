return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				disable = { "latex" },
			},
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"css",
				"gitignore",
				"html",
				"json",
				"javascript",
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
