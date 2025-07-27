return {
	"lervag/wiki.vim",
	init = function()
		vim.g.wiki_root = "~/Documents/notes"

		-- Make newly created links lowercase and replace spaces with dashes
		vim.g.wiki_link_creation = {
			md = {
				url_transform = function(x)
					return string.gsub(string.lower(x), "%s+", "-")
				end,
			},
		}

		-- Have journal notes in the root directory to make links easier
		-- vim.g.wiki_journal = {
		-- 	name = "",
		-- 	root = "",
		-- }
	end,
}
