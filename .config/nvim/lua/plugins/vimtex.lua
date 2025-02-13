return {
	"lervag/vimtex",
	lazy = false,
	-- set pdf viewer
	init = function()
		if vim.fn.has("win32") == 1 then
			vim.g.vimtex_view_method = "sioyek"
		else
			vim.g.vimtex_view_method = "zathura"
		end
		-- don't open QuickFix for warnings only
		vim.g.vimtex_quickfix_open_on_warning = false

		local au_group = vim.api.nvim_create_augroup("vimtex_events", {})

		-- cleanup on quit
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventQuit",
			group = au_group,
			command = "VimtexClean",
		})

		-- focus the terminal after inverse search
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventViewReverse",
			group = au_group,
			command = "call b:vimtex.viewer.xdo_focus_neovim()",
		})
	end,
}
