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

vim.o.conceallevel = 2

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
