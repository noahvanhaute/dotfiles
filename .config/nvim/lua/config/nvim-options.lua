-- [[ Globals ]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- [[ Options ]]
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false

vim.o.number = true
vim.o.relativenumber = true

vim.o.winborder = "rounded"

vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim
-- Schedule after 'UiEnter' because it can increase startup-time
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Clipboard needs to be redefined when using wsl
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

vim.o.breakindent = true

vim.o.linebreak = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250

vim.o.timeoutlen = 500

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
-- Use `opt` here as it has an interface for interacting with tables
vim.opt.listchars = { tab = "  ", trail = "·" }

vim.o.cursorline = true

vim.o.scrolloff = 10

-- [[ Keymamps ]]

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights with <Esc>" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Autocommands ]]

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

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
		vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/dictionary.utf-8.add"
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
