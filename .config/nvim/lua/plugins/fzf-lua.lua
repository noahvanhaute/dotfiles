return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			fzf_colors = true,
		})
	end,
}
