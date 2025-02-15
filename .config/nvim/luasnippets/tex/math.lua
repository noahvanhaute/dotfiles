-- all snippets related to math in LaTeX
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- function to pass as a condintion for only tiggering in math mode
local in_mathzone = function()
	-- requires the VimTeX plugin
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- defining greek letter tiggers
local trig1 = "g"
local trig2 = {
	{ "a", "\\alpha" },
	{ "b", "\\beta" },
	{ "g", "\\gamma" },
	{ "G", "\\Gamma" },
	{ "d", "\\delta" },
	{ "D", "\\Delta" },
	{ "ep", "\\epsilon" },
	{ "vep", "\\epsilon" },
	{ "z", "\\zeta" },
	{ "et", "\\eta" },
	{ "t", "\\theta" },
	{ "T", "\\Theta" },
	{ "vt", "\\vartheta" },
	{ "i", "\\iota" },
	{ "k", "\\kappa" },
	{ "l", "\\lambda" },
	{ "L", "\\Lambda" },
	{ "m", "\\mu" },
	{ "M", "\\Mu" },
	{ "n", "\\nu" },
	{ "x", "\\xi" },
	{ "X", "\\Xi" },
	{ "pi", "\\pi" },
	{ "Pi", "\\Pi" },
	{ "r", "\\rho" },
	{ "s", "\\sigma" },
	{ "S", "\\Sigma" },
	{ "t", "\\tau" },
	{ "u", "\\upsilon" },
	{ "U", "\\Upsilon" },
	{ "ph", "\\phi" },
	{ "Ph", "\\Phi" },
	{ "vph", "\\varphi" },
	{ "c", "\\chi" },
	{ "ps", "\\psi" },
	{ "Ps", "\\Psi" },
	{ "o", "\\omega" },
	{ "O", "\\Omega" },
}

-- adding greek letter snippets
for index, v in ipairs(trig2) do
	local trigger = trig1 .. v[1]
	local letter = v[2]
	ls.add_snippets("tex", {
		s({ trig = trigger, snippetType = "autosnippet" }, t(letter), { condition = in_mathzone }),
	})
end

-- rest of the snippets
ls.add_snippets("tex", {
	-- inline math
	s("im", fmta("\\(<>\\) ", { i(1) })),

	-- display math
	s("dm", fmta("\\[<>\\]", { i(1) })),

	-- equation environment
	s(
		"eq",
		fmta(
			[=[
            \begin{equation}
                <>
                \label{eq:<>}
            \end{equation}

            ]=],
			{ i(1), i(2) }
		)
	),

	-- align environment
	s(
		"al",
		fmta(
			[=[
            \begin{align}
                <>
                \label{eq:<>}
            \end{align}

            ]=],
			{ i(1), i(2) }
		)
	),

	-- array environment
	s(
		{ trig = "arr", snippetType = "autosnippet" },
		fmta(
			[=[
            \begin{array}{<>}
                <>
            \end{array}

            ]=],
			{ i(2), i(1) }
		),
		{ condition = in_mathzone }
	),

	-- square bracket matrix environment
	s(
		{ trig = "bm", snippetType = "autosnippet" },
		fmta(
			[=[
            \begin{bmatrix}
                <>
            \end{bmatrix}

            ]=],
			{ i(1) }
		),
		{ condition = in_mathzone }
	),

	-- text formatting
	s({ trig = "tt", snippetType = "autosnippet" }, fmta("\\text{<>}", { i(1) }), { condition = in_mathzone }),

	-- bold formatting
	s({ trig = "bf", snippetType = "autosnippet" }, fmta("\\mathbf{<>}", { i(1) }), { condition = in_mathzone }),

	-- bold formatting for symbols
	s({ trig = "sbf", snippetType = "autosnippet" }, fmta("\\boldsymbol{<>}", { i(1) }), { condition = in_mathzone }),

	-- roman math
	s({ trig = "mrm", snippetType = "autosnippet" }, fmta("\\mathrm{<>}", { i(1) }), { condition = in_mathzone }),

	-- roman text
	s({ trig = "trm", snippetType = "autosnippet" }, fmta("\\textrm{<>}", { i(1) }), { condition = in_mathzone }),

	-- caligraphic math
	s({ trig = "cal", snippetType = "autosnippet" }, fmta("\\mathcal{<>}", { i(1) }), { condition = in_mathzone }),

	-- blackboard bold math
	s({ trig = "bb", snippetType = "autosnippet" }, fmta("\\mathbb{<>}", { i(1) }), { condition = in_mathzone }),

	-- subscript
	s(
		{ trig = "([%a%)%]%}])ss", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- text subscript
	s(
		{ trig = "([%a%)%]%}])ts", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{\\text{<>}}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- multiplication dot
	s({ trig = "cd", snippetType = "autosnippet" }, t("\\cdot "), { condition = in_mathzone }),

	-- multiplication X
	s({ trig = "xx", snippetType = "autosnippet" }, t("\\times "), { condition = in_mathzone }),

	-- division
	s({ trig = "div", snippetType = "autosnippet" }, t("\\div "), { condition = in_mathzone }),

	-- fraction
	s(
		{ trig = "ff", snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", { i(1), i(2) }),
		{ condition = in_mathzone }
	),

	-- inverting
	s(
		{ trig = "([%a%d%)%]%}])iv", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{-1}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- squaring
	s(
		{ trig = "([%a%d%)%]%}])sr", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{2}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- cubing
	s(
		{ trig = "([%a%d%)%]%}])cb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{3}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- raising to a power
	s(
		{ trig = "([%a%d%)%]%}])rd", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- square root
	s({ trig = "sq", snippetType = "autosnippet" }, fmta("\\sqrt{<>}", { i(1) }), { condition = in_mathzone }),

	-- centered elipses
	s({ trig = "cel", snippetType = "autosnippet" }, t("\\cdots "), { condition = in_mathzone }),

	-- elipses
	s({ trig = "el", snippetType = "autosnippet" }, t("\\ldots "), { condition = in_mathzone }),

	-- differential
	-- requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	s({ trig = "df", snippetType = "autosnippet" }, t("\\diff "), { condition = in_mathzone }),

	-- partial
	s({ trig = "pt", snippetType = "autosnippet" }, t("\\partial "), { condition = in_mathzone }),

	-- higher order differential
	-- requires `\newcommand*\Diff[1]{\mathop{}\!\mathrm{d^#1}}`
	s({ trig = "Df", snippetType = "autosnippet" }, fmta("\\Diff{<>}", { i(1) }), { condition = in_mathzone }),

	-- higher order partial
	s({ trig = "Pt", snippetType = "autosnippet" }, fmta("\\partial^{<>} ", { i(1) }), { condition = in_mathzone }),

	-- derivative
	-- requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	s(
		{ trig = "dv", snippetType = "autosnippet" },
		fmta("\\frac{\\diff <>}{\\diff <>}", { i(1), i(2) }),
		{ condition = in_mathzone }
	),

	-- partial derivative
	s(
		{ trig = "pd", snippetType = "autosnippet" },
		fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) }),
		{ condition = in_mathzone }
	),

	-- higher order derivative
	-- requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	-- requires `\newcommand*\Diff[1]{\mathop{}\!\mathrm{d^#1}}`
	s(
		{ trig = "Dv", snippetType = "autosnippet" },
		fmta("\\frac{\\Diff{<>}<>}{\\diff <>^<>}", { i(1), i(2), i(3), rep(1) }),
		{ condition = in_mathzone }
	),

	-- higher order partial derivative
	s(
		{ trig = "Pd", snippetType = "autosnippet" },
		fmta("\\frac{\\partial^{<>}<>}{\\partial <>^<>}", { i(1), i(2), i(3), rep(1) }),
		{ condition = in_mathzone }
	),

	-- first derivative Newton's notation
	s({ trig = "dot", snippetType = "autosnippet" }, fmta("\\dot{<>}", { i(1) }), { condition = in_mathzone }),

	-- second derivative Newton's notation
	s({ trig = "ddot", snippetType = "autosnippet" }, fmta("\\ddot{<>}", { i(1) }), { condition = in_mathzone }),

	-- third derivative Newton's notation
	s({ trig = "dddot", snippetType = "autosnippet" }, fmta("\\dddot{<>}", { i(1) }), { condition = in_mathzone }),

	-- integral
	s({ trig = "int", snippetType = "autosnippet" }, t("\\int "), { condition = in_mathzone }),

	-- double integral
	s({ trig = "iint", snippetType = "autosnippet" }, t("\\iint "), { condition = in_mathzone }),

	-- triple integral
	s({ trig = "iiint", snippetType = "autosnippet" }, t("\\iiint "), { condition = in_mathzone }),

	-- defined integral
	s(
		{ trig = "dint", snippetType = "autosnippet" },
		fmta("\\int_{<>}^{<>}", { i(1), i(2) }),
		{ condition = in_mathzone }
	),

	-- defined double integral
	s(
		{ trig = "diint", snippetType = "autosnippet" },
		fmta("\\int_{<>}^{<>}\\int_{<>}^{<>}", { i(1), i(2), i(3), i(4) }),
		{ condition = in_mathzone }
	),

	-- defined triple integral
	s(
		{ trig = "diiint", snippetType = "autosnippet" },
		fmta("\\int_{<>}^{<>}\\int_{<>}^{<>}\\int_{<>}^{<>}", { i(1), i(2), i(3), i(4), i(5), i(6) }),
		{ condition = in_mathzone }
	),

	-- sine
	s({ trig = "sin", snippetType = "autosnippet" }, t("\\sin"), { condition = in_mathzone }),

	-- cosine
	s({ trig = "cos", snippetType = "autosnippet" }, t("\\cos"), { condition = in_mathzone }),

	-- tangent
	s({ trig = "tan", snippetType = "autosnippet" }, t("\\tan"), { condition = in_mathzone }),

	-- arcsine
	s({ trig = "asin", snippetType = "autosnippet" }, t("\\arcsin"), { condition = in_mathzone }),

	-- arccosine
	s({ trig = "acos", snippetType = "autosnippet" }, t("\\arccos"), { condition = in_mathzone }),

	-- arctangent
	s({ trig = "atan", snippetType = "autosnippet" }, t("\\arctan"), { condition = in_mathzone }),

	-- cosecant
	s({ trig = "csc", snippetType = "autosnippet" }, t("\\csc"), { condition = in_mathzone }),

	-- secant
	s({ trig = "sec", snippetType = "autosnippet" }, t("\\sec"), { condition = in_mathzone }),

	-- cotangent
	s({ trig = "cot", snippetType = "autosnippet" }, t("\\cot"), { condition = in_mathzone }),
})
