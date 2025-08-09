return {
	"maxmx03/solarized.nvim",
	lazy = false,
	priority = 1000,
	---@type solarized.config
	opts = {},
	config = function()
		require("solarized").setup({
			transparent = {
				enabled = true,
			},
		})
		vim.cmd.colorscheme("solarized")
		vim.o.background = "dark"
		vim.o.termguicolors = true
	end,
}
