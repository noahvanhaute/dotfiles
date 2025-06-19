return {
	"lervag/wiki.vim",
	init = function()
		vim.g.wiki_root = "~/Documents/notes"

		vim.g.wiki_link_creation = {
			md = {
				url_transform = function(x)
					return string.gsub(string.lower(x), "%s+", "-")
				end,
			},
		}
	end,
}
