return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	-- Build step is needed for regex support in snippets
	build = "make install_jsregexp",

	config = function()
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_lua").lazy_load()
		luasnip.config.setup({
			enable_autosnippets = true,
			cut_selection_keys = "<leader>ss",
		})

		vim.keymap.set(
			"n",
			"<leader><leader>s",
			':lua require("luasnip.loaders.from_lua").load()<CR>',
			{ desc = "reload [S]nippets" }
		)
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { desc = "Move to the right of expansion", silent = true })
		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { desc = "Move to the left of expansion", silent = true })
	end,
}
