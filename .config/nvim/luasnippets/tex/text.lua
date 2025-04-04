-- all snippets related to text in LaTeX
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

ls.add_snippets("tex", {
	-- chapter
	s(
		"ch",
		fmta(
			[=[
			\chapter{<>}

			]=],
			{ i(1) }
		)
	),

	-- section
	s(
		"se",
		fmta(
			[=[
			\section{<>}

			]=],
			{ i(1) }
		)
	),

	-- paragraph
	s(
		"pa",
		fmta(
			[=[
			\paragraph{<>}

			]=],
			{ i(1) }
		)
	),

	-- TikZ figure
	s(
		"tfg",
		fmta(
			[=[
			\begin{figure}[H]
				\centering
				\input{figures/<>}
				\caption{<>}
				\label{fig:<>}
			\end{figure}

			]=],
			{ i(1), i(2), i(3) }
		)
	),

	-- label
	s("la", fmta("\\label{<>}", { i(1) })),

	-- citation
	s("ci", fmta("\\cite{<>}", { i(1) })),

	-- reference
	s("rr", fmta("\\ref{<>}", { i(1) })),

	-- clever reference
	s("cc", fmta("\\cref{<>}", { i(1) })),

	-- clever reference
	s("CC", fmta("\\Cref{<>}", { i(1) })),
})
