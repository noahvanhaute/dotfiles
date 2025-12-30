return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"bash",
			"gitignore",
			"json",
			"ron",
			"yaml",
		})
	end,
}
