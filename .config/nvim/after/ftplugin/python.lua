vim.opt_local.textwidth = 88
vim.opt_local.formatoptions:remove("t")
vim.treesitter.start()
vim.cmd.compiler("python")
