-- [[ Bootsrap package manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Globals ]]

vim.g.have_nerd_font = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.markdown_recommended_style = false

-- [[ Options ]]

-- Sync clipboard between OS and Neovim
-- Schedule after 'UiEnter' because it can increase startup-time
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true
vim.o.linebreak = true
vim.o.expandtab = false
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.list = true
-- Use `opt` here as it has an interface for interacting with tables
vim.opt.listchars = { tab = "  ", trail = "·" }
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.scrolloff = 10
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.winborder = "rounded"

-- [[ Keymamps ]]

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights with <Esc>" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- [[ Autocommands ]]

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Return to last edit position when opening files",
	group = vim.api.nvim_create_augroup("return-position", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "LaTeX specific settings",
	group = vim.api.nvim_create_augroup("latex-settings", { clear = true }),
	pattern = { "tex" },
	callback = function()
		vim.o.conceallevel = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Markdown specific settings",
	group = vim.api.nvim_create_augroup("markdown-settings", { clear = true }),
	pattern = { "markdown" },
	callback = function()
		-- Turn off spell for floating windows so that `vim.lsp.buf.hover()
		--  isn't spellchecked
		vim.opt_local.spell = not vim.api.nvim_win_get_config(0).zindex

		-- The utf-8.spl and .utf-8.sug files for your languages should be downloaded from
		--  https://ftp.nluug.nl/vim/runtime/spell/
		--  (Enlgish is provided by default)
		--  and placed in ~/.config/nvim/spell
		vim.opt_local.spelllang = { "en_us", "nl" }

		-- Use a custom dictionary that stores unrecognized words for each language
		vim.opt_local.spellfile = vim.fn.stdpath("config") .. "/spell/dictionary.utf-8.add"

		vim.keymap.set(
			"n",
			"<Tab>",
			"<cmd>call search('\\[.\\+\\]\\(.\\+\\)')<CR>",
			{ buffer = true, desc = "Find next link" }
		)
		vim.keymap.set(
			"n",
			"<S-Tab>",
			"<cmd>call search('\\[.\\+\\]\\(.\\+\\)', 'b')<CR>",
			{ buffer = true, desc = "Find previous link" }
		)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ WSL ]]

-- Clipboard needs to be redefined when using WSL
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = true,
	}
	vim.keymap.set({ "n", "v" }, "y", '"+y', { noremap = true, silent = true })
	vim.keymap.set({ "n", "v" }, "p", '"+p', { noremap = true, silent = true })
end

-- [[ Package manager ]]

require("lazy").setup({
	checker = { enabled = false },
	install = { colorscheme = { "solarized" } },
	spec = { { import = "plugins" } },
	ui = { border = "rounded" },
})

-- [[ LSP ]]

vim.lsp.enable({ "clangd", "ltex_plus", "lua_ls", "tinymist" })

vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local fzf = require("fzf-lua")

		-- All keymaps are the same as, or in the spirit of, the defaults
		map("gra", vim.lsp.buf.code_action, "[G]oto code [A]ction", { "n", "x" })
		-- Different from definition, in C this would take you to the header
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("grd", fzf.lsp_definitions, "[G]oto [D]efinition")
		map("gri", fzf.lsp_implementations, "[G]oto [I]mplementation")
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("grr", fzf.lsp_references, "[G]oto [R]eferences")
		map("grt", fzf.lsp_typedefs, "[G]oto [T]ype definition")

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
