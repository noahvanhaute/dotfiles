vim.lsp.config("ltex_plus", {
	cmd = { "ltex-ls-plus" },
	filetypes = { "bib", "tex" },
	root_markers = { { ".git" } },
	settings = {
		ltex = {
			enabled = { "latex", "tex" },
			latex = {
				commands = {
					["\\bamadegree{}"] = "ignore",
					["\\ce{}"] = "dummy",
					["\\lstinputlisting[]{}"] = "ignore",
					["\\pgfdeclarelayer{}"] = "ignore",
					["\\pgfplotsset{}"] = "ignore",
					["\\pgfsetlayers{}"] = "ignore",
					["\\qty{}{}"] = "dummy",
					["\\qtyrange[]{}{}"] = "dummy",
					["\\setmathfont{}[]"] = "ignore",
					["\\setmonofont{}[]"] = "ignore",
					["\\setsansfont{}[]"] = "ignore",
					["\\texorpdfstring{}{}"] = "dummy",
					["\\unit{}"] = "ignore",
					["\\usecolortheme{}"] = "ignore",
					["\\usefonttheme{}"] = "ignore",
					["\\useinnertheme{}"] = "ignore",
					["\\useoutertheme{}"] = "ignore",
					["\\UseTblrLibrary{}"] = "ignore",
					["\\usetheme{}"] = "ignore",
				},
			},
		},
	},
	on_attach = function()
		require("ltex_extra").setup({
			path = (vim.fn.stdpath("config")) .. "/ltex_extra",
		})
	end,
})
vim.lsp.enable({ "ltex_plus" })

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = { disable = { "missing-fields" } },
			hint = { enable = true },
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
					"~/.local/share/nvim/lazy/solarized.nvim",
				},
			},
		},
	},
})
vim.lsp.enable({ "lua_ls" })

vim.lsp.config("tinymist", {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	root_markers = { ".git" },
	settings = {
		exportPdf = "onSave",
	},
})
vim.lsp.enable({ "tinymist" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local fzf = require("fzf-lua")

		-- All keymaps are the same as, or in the spirit of, the defaults
		map("grd", fzf.lsp_definitions, "[G]oto [D]efinition")
		map("grr", fzf.lsp_references, "[G]oto [R]eferences")
		map("gri", fzf.lsp_implementations, "[G]oto [I]mplementation")
		map("grt", fzf.lsp_typedefs, "[G]oto [T]ype definition")
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gra", vim.lsp.buf.code_action, "[G]oto code [A]ction", { "n", "x" })
		-- Different from definition, in C this would take you to the header
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Highlight references of the word under the cursor
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

vim.diagnostic.config({ virtual_lines = { current_line = true } })
