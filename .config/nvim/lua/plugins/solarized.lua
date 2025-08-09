return {
	"maxmx03/solarized.nvim",
	lazy = false,
	priority = 1000,
	---@type solarized.config
	opts = {},
	config = function()
		require("solarized").setup({
			on_highlights = function(colors)
				---@type solarized.highlights
				local groups = {
					SpellBad = { underline = false, strikethrough = false, sp = colors.red, undercurl = true },
					SpellCap = { sp = colors.violet, undercurl = true },
					SpellLocal = { sp = colors.yellow, undercurl = true },
					SpellRare = { sp = colors.cyan, undercurl = true },
				}
				return groups
			end,
			transparent = {
				enabled = true,
			},
		})
		vim.cmd.colorscheme("solarized")
		vim.o.background = "dark"
		vim.o.termguicolors = true
	end,
}
