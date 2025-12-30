vim.treesitter.start()
vim.cmd.compiler("pyunit")
vim.opt_local.makeprg = "python3 %"
