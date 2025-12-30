vim.treesitter.start()

-- Turn off spell for floating windows so that `vim.lsp.buf.hover()`
--  isn't spellchecked
vim.opt_local.spell = not vim.api.nvim_win_get_config(0).zindex

vim.keymap.set("n", "<Tab>", "<cmd>call search('\\[.\\+\\]\\(.\\+\\)')<CR>", { buffer = true, desc = "Find next link" })
vim.keymap.set(
	"n",
	"<S-Tab>",
	"<cmd>call search('\\[.\\+\\]\\(.\\+\\)', 'b')<CR>",
	{ buffer = true, desc = "Find previous link" }
)
