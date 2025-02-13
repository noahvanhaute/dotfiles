return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- snippet engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- build step is needed for regex support in snippets
				-- doesn't work on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",

		-- other completion capabilities.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function()
		-- `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_lua").lazy_load()
		luasnip.config.setup({
			enable_autosnippets = true,
			-- [S]tore [S]election
			cut_selection_keys = "<leader>ss",
		})

		-- keymap to reload snippets
		vim.keymap.set(
			"n",
			"<leader><leader>s",
			':lua require("luasnip.loaders.from_lua").load()<CR>',
			{ desc = "reload [S]nippets" }
		)

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },

			-- `:help ins-completion`
			mapping = cmp.mapping.preset.insert({
				-- select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- accept ([y]es) the completion.
				--  will auto-import if your LSP supports it.
				--  will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				-- manually trigger a completion from nvim-cmp.
				["<C-Space>"] = cmp.mapping.complete({}),

				-- move to the right of expansion
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				-- move to the left of expansion
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{
					name = "lazydev",
					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "vimtex" },
			},
		})
	end,
}
