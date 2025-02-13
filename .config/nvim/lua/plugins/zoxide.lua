return {
	"nanotee/zoxide.vim",
	config = function()
		vim.keymap.set("n", "<leader>cd", ":Z ", { desc = "[C]hange [D]irectory with zoxide" })
	end,
}
