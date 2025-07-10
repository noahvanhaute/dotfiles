return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		latex = { enabled = false },
		win_options = { conceallevel = { rendered = 2 } },
		on = {
			render = function()
				require("nabla").enable_virt()
			end,
			clear = function()
				require("nabla").disable_virt()
			end,
		},
	},
}
