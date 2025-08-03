return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		-- Mason must be loaded before its dependents so we need to set it up here
		-- `opts = {}` is the same as calling `require('mason').setup({})`
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",

		-- For adding to dictionary, disabling rules and hiding false positives
		"barreiroleo/ltex-extra.nvim",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- Helper function for keymaps
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local fzf = require("fzf-lua")

				map("grd", fzf.lsp_definitions, "[G]oto [D]efinition")
				map("grr", fzf.lsp_references, "[G]oto [R]eferences")
				map("gri", fzf.lsp_implementations, "[G]oto [I]mplementation")
				map("grt", fzf.lsp_typedefs, "[G]oto [T]ype definition")
				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("gra", vim.lsp.buf.code_action, "[G]oto code [A]ction", { "n", "x" })
				-- Different from definition, in C this would take you to the header
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Highlight references of the word under the cursor
				-- `:help CursorHold`
				-- Second autocommand clears on cursor move
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight)
				then
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

				-- Toggle inlay hints if the language server supports them
				if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Available keys for override configuration are:
		--  - cmd (table): override the default command used to start the server
		--  - filetypes (table): override the default list of associated filetypes for the server
		--  - capabilities (table): override fields in capabilities, can be used to disable certain LSP features
		--  - settings (table): override the default settings passed when initializing the server
		local servers = {
			ltex = {
				filetypes = { "bib", "tex" },
				on_attach = function(client, bufnr)
					require("ltex_extra").setup({
						path = (vim.fn.stdpath("config")) .. "/ltex_extra",
					})
				end,
				settings = {
					ltex = {
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
			},
			lua_ls = {
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
			},
			tinymist = {
				settings = {
					exportPdf = "onSave",
					formatterMode = "typstyle",
				},
			},
		}

		-- Ensure the servers and tools above are installed
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"latexindent",
			"stylua",
			"tree-sitter-cli",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- Handles overriding only values explicitly passed
					--  by the server configuration above.
					--  Useful when disabling certain features of an LSP.
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
