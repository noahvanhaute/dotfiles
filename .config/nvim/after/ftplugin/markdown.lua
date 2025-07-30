-- The utf-8.spl and .utf-8.sug files for your languages should be downloaded from
--  https://ftp.nluug.nl/vim/runtime/spell/
--  (Enlgish is provided by default)
--  and placed in ~/.config/nvim/spell
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us", "nl" }

-- Use a custom dictionary that stores unrecognized words for each language
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/dictionary.utf-8.add"
