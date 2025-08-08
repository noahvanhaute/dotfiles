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
				"gitignore",
				"json",
				"latex",
				"markdown_inline",
				"ron",
				"vim",
				"yaml",
			},
		})
	end,
}
