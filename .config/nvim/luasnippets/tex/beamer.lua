-- All snippets related to math in LaTeX
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

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
