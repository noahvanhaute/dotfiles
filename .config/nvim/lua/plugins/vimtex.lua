return {
	"lervag/vimtex",
	lazy = false,

	init = function()
		vim.g.vimtex_quickfix_open_on_warning = false
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
		vim.g.vimtex_view_method = "zathura_simple"

		-- Use fzf-lua for ToC
		vim.keymap.set("n", "<localleader>lt", function()
			return require("vimtex.fzf-lua").run()
		end)

		-- Cleanup on quit
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventQuit",
			group = vim.api.nvim_create_augroup("vimtex_events", {}),
			command = "VimtexClean",
		})
	end,
}
