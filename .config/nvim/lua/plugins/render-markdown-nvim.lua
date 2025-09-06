return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig

	config = function()
		vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { link = "Conceal", underline = true })
		vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { link = "Normal" })

		require("render-markdown").setup({
			code = { width = "block", min_width = 90 },
			html = { enabled = false },
			latex = { enabled = false },
			sign = { enabled = false },
		})
	end,
}
