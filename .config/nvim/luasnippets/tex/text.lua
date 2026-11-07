-- Function to pass as a condition for only triggering outside of math mode
local not_in_mathzone = function()
	-- Requires the VimTeX plugin
	return vim.fn["vimtex#syntax#in_mathzone"]() == 0
end

return {
	-- Chapter
	s(
		{ trig = "ch", condition = not_in_mathzone },
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
			\begin{figure}[<>]
				\centering
				\includegraphics[<>]{<>}
				\caption{<>}
				\label{fig-<>}
			\end{figure}
			]=],
			{ i(1), i(2), i(3), i(4), i(5) }
		)
	),

	-- TikZ figure
	s(
		"tfg",
		fmta(
			[=[
			\begin{figure}[<>]
				\centering
				\input{figures/<>}
				\caption{<>}
				\label{fig-<>}
			\end{figure}
			]=],
			{ i(1), i(2), i(3), i(4) }
		)
	),

	-- Label
	s("lb", fmta("\\label{<>}", { i(1) })),

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
}
