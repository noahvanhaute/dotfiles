return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")
		oil.setup()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory with oil" })
	end,
}
