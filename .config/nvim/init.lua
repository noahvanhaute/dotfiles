-- [[ Bootstrap package manager ]]
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

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.markdown_recommended_style = false

-- [[ Options ]]

-- Sync clipboard between OS and Neovim
-- Schedule after 'UiEnter' because it can increase startup-time
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- `opt` needed sometimes as it accepts tables
-- The utf-8.spl and .utf-8.sug files for your languages should be downloaded from
--  https://ftp.nluug.nl/vim/runtime/spell/
--  (English is provided by default)
--  and placed in ~/.config/nvim/spell
-- Using a custom dictionary that stores unrecognized words for each language
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.expandtab = false
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·" }
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.scrolloff = 10
vim.o.spellfile = vim.fn.stdpath("config") .. "/spell/dictionary.utf-8.add"
vim.opt.spelllang = { "en_us", "nl" }
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.winborder = "rounded"
vim.opt.completeopt = { "fuzzy", "menuone", "noinsert", "popup" }

-- [[ Keymaps ]]

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

vim.lsp.enable({ "ltex_plus", "lua_ls", "tinymist" })

vim.diagnostic.config({ virtual_lines = { current_line = true } })
