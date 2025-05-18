return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- automatically install LSPs and related tools to stdpath for Neovim
		-- mason must be loaded before its dependents so we need to set it up here
		-- `opts = {}` is the same as calling `require('mason').setup({})`
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",

		-- for adding to dictionary, disabling rules and hiding false positives
		"barreiroleo/ltex-extra.nvim",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- helper function for keymaps
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- jump to the definition of the word under your cursor.
				-- to jump back, press <C-t>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- find references for the word under your cursor.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- jump to the implementation of the word under your cursor.
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- jump to the type of the word under your cursor.
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- fuzzy find all the symbols in your current document.
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- fuzzy find all the symbols in your current workspace.
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- rename the variable under your cursor.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- format the curent buffer
				-- map("<leader>af", vim.lsp.buf.format, "[A]uto [F]ormat")

				-- execute a code action
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- this is not Goto Definition, this is Goto Declaration.
				-- for example, in C this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- highlight references of the word under the cursor
				-- `:help CursorHold`
				-- second autocommand clears on cursor move
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- toggle inlay hints if the language server supports them
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- available keys for override configuratoin are:
		--  - cmd (table): override the default command used to start the server
		--  - filetypes (table): override the default list of associated filetypes for the server
		--  - capabilities (table): override fields in capabilities, can be used to disable certain LSP features
		--  - settings (table): override the default settings passed when initializing the server
		local servers = {
			ltex = {
				on_attach = function(client, bufnr)
					-- rest of your on_attach process.
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
			prettier = {},
			pyright = {},
			tinymist = {
				settings = {
					formatterMode = "typstyle",
				},
			},
		}

		-- ensure the servers and tools above are installed
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"latexindent",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- handles overriding only values explicitly passed
					-- by the server configuration above
					-- useful when disabling certain features of an LSP
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
