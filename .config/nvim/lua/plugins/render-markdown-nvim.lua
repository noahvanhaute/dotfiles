return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = { html = { enabled = false }, latex = { enabled = false } },
	config = function()
		require("render-markdown").setup({
			code = { width = "block", min_width = 90 },
			sign = { enabled = false },
		})
	end,
}
