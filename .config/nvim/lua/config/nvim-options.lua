-- set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable nerd font
vim.g.have_nerd_font = true

-- a TAB character counts for 4 spaces
vim.o.tabstop = 4
-- a TAB character counts for 4 spaces while editing
vim.o.softtabstop = 4
-- number of spaces inserted when indenting
vim.o.shiftwidth = 4
-- pressing the TAB key will insert a real TAB character
vim.o.expandtab = false

-- [[ options ]]

-- set default shell to powershell when using windows
if vim.fn.has("win32") == 1 then
	vim.o.shell = "powershell"
	vim.o.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end

-- enable line numbering
vim.opt.number = true
-- set relative line numbering
vim.opt.relativenumber = true

-- enable mouse mode for resizing splits etc
vim.opt.mouse = "a"

-- sync clipboard between OS and Neovim
-- schedule after 'UiEnter' because it can increase startup-time
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- clipboard needs to be redefined when using wsl
if vim.fn.has("wsl") then
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

-- enable break indent
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- case-insensitive searching UNLESS \C or one or more capitals in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
vim.opt.timeoutlen = 500

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- display certain whitespace characters in the editor
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·" }

-- highlight which line the cursor is on
vim.opt.cursorline = true

-- concealed text
vim.opt.conceallevel = 2

-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- [[ keymamps ]]

-- clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- alternative to exit terminal mode in builtin
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  use CTRL+<hjkl> to switch between windows
--  `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ autocommands ]]

-- highlight text being yanked
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
