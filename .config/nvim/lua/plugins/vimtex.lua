return {
	"lervag/vimtex",
	lazy = false,

	init = function()
		vim.g.vimtex_syntax_nospell_comments = true

		vim.g.vimtex_quickfix_open_on_warning = false

		vim.g.vimtex_view_method = "zathura_simple"

		vim.keymap.set("n", "<localleader>lt", function()
			return require("vimtex.fzf-lua").run()
		end, { desc = "Seach through table of contents with fzf-lua" })

		-- Cleanup on quit
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventQuit",
			group = vim.api.nvim_create_augroup("vimtex_events", {}),
			command = "VimtexClean",
		})
	end,
}
