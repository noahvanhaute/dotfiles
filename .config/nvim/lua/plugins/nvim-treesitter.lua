return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- Configure treesitter
		treesitter.setup({ -- Enable syntax highlighting
			highlight = {
				enable = true,
				disable = { "latex" },
			},
			-- Enable indentation
			indent = { enable = true },
			-- Enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- Ensure these language parsers are installed
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
