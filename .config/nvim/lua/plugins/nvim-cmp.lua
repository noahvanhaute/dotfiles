return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build step is needed for regex support in snippets
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",

		-- Other completion capabilities.
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

		-- Keymap to reload snippets
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
				-- Select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Accept ([y]es) the completion
				-- Will auto-import if your LSP supports it
				-- Will expand snippets if the LSP sent a snippet
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				-- Manually trigger a completion from nvim-cmp.
				["<C-Space>"] = cmp.mapping.complete({}),

				-- Move to the right of expansion
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				-- Move to the left of expansion
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "vimtex" },
			},
		})
	end,
}
