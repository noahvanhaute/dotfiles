local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets("tex", {
	-- Frame environment
	s(
		"fr",
		fmta(
			[=[
            \begin{frame}{<>}{<>}
                <>
            \end{frame}
            ]=],
			{ i(1), i(2), i(3) }
		)
	),
})
