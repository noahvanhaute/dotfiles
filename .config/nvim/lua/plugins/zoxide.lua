return {
	"nanotee/zoxide.vim",
	config = function()
		vim.keymap.set("n", "<leader>cd", ":Z ", { desc = "[C]hange [D]irectory with zoxide" })
	end,
	init = function()
		require("fzf-lua").register_ui_select()
		vim.g.zoxide_use_select = 1
	end,
}
