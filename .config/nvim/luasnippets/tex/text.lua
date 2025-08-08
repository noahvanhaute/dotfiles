local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets("tex", {
	-- Chapter
	s(
		"ch",
		fmta(
			[=[
			\chapter{<>}
			]=],
			{ i(1) }
		)
	),

	-- Section
	s(
		"se",
		fmta(
			[=[
			\section{<>}
			]=],
			{ i(1) }
		)
	),

	-- Subsection
	s(
		"su",
		fmta(
			[=[
			\subsection{<>}
			]=],
			{ i(1) }
		)
	),

	-- Paragraph
	s(
		"pa",
		fmta(
			[=[
			\paragraph{<>}
			]=],
			{ i(1) }
		)
	),

	-- Itemize
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

	-- Enumerate
	s(
		"en",
		fmta(
			[=[
			\begin{enumerate}
				\item <>
			\end{enumerate}
			]=],
			{ i(1) }
		)
	),

	-- Figure
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

	-- Label
	s("la", fmta("\\label{<>}", { i(1) })),

	-- Item
	s("it", t("\\item ")),

	-- Citation
	s("ci", fmta("\\cite{<>}", { i(1) })),

	-- Reference
	s("rr", fmta("\\ref{<>}", { i(1) })),

	-- Clever reference
	s("cc", fmta("\\cref{<>}", { i(1) })),

	-- Clever reference
	s("CC", fmta("\\Cref{<>}", { i(1) })),

	-- Chemical equation
	-- Requires mhchem package
	s("ce", fmta("\\ce{<>}", { i(1) })),
})
