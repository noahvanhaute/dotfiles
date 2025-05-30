return {
	"lervag/vimtex",
	lazy = false,

	init = function()
		-- set pdf viewer
		vim.g.vimtex_view_method = "zathura"

		-- don't open QuickFix for warnings only
		vim.g.vimtex_quickfix_open_on_warning = false

		-- fzf-lua for ToC
		vim.keymap.set("n", "<localleader>lt", function()
			return require("vimtex.fzf-lua").run()
		end)

		local au_group = vim.api.nvim_create_augroup("vimtex_events", {})

		-- cleanup on quit
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventQuit",
			group = au_group,
			command = "VimtexClean",
		})
	end,
}
