return {
	"lervag/vimtex",
	lazy = false,

	init = function()
		-- set pdf viewer
		vim.g.vimtex_view_method = "zathura"

		-- don't open QuickFix for warnings only
		vim.g.vimtex_quickfix_open_on_warning = false

		-- disable conceal for spacing commands
		vim.g.vimtex_syntax_conceal = {
			["accents"] = 1,
			["ligatures"] = 1,
			["cites"] = 1,
			["fancy"] = 1,
			["spacing"] = 0,
			["greek"] = 1,
			["math_bounds"] = 1,
			["math_delimiters"] = 1,
			["math_fracs"] = 1,
			["math_super_sub"] = 1,
			["math_symbols"] = 1,
			["sections"] = 0,
			["styles"] = 1,
		}

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
