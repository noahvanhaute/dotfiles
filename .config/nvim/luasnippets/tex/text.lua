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

	-- subsection
	s(
		"su",
		fmta(
			[=[
			\subsection{<>}
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

	-- itemize
	s(
		"iz",
		fmta(
			[=[
			\begin{itemize}
				\item <>
			\end{itemize}
			]=],
			{ i(1) }
		)
	),

	-- figure
	s(
		"fg",
		fmta(
			[=[
			\begin{figure}[H]
				\centering
				\includegraphics[<>]{<>}
				\caption{<>}
				\label{fig:<>}
			\end{figure}
			]=],
			{ i(1), i(2), i(3), i(4) }
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

	-- item
	s("it", t("\\item ")),

	-- citation
	s("ci", fmta("\\cite{<>}", { i(1) })),

	-- reference
	s("rr", fmta("\\ref{<>}", { i(1) })),

	-- clever reference
	s("cc", fmta("\\cref{<>}", { i(1) })),

	-- clever reference
	s("CC", fmta("\\Cref{<>}", { i(1) })),

	-- chemical equation
	-- requires mhchem package
	s("ce", fmta("\\ce{<>}", { i(1) })),
})
