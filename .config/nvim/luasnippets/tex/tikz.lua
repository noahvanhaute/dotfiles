-- All snippets related to TikZ in LaTeX
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

ls.add_snippets("tex", {
	-- tikzpicture environment
	s(
		"tk",
		fmta(
			[=[
			\begin{tikzpicture}
				<>
			\end{tikzpicture}
			]=],
			{ i(1) }
		)
	),
})
