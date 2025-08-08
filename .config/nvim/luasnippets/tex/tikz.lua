local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

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
