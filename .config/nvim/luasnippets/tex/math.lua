-- Function to pass as a condintion for only tiggering in math mode
local in_mathzone = function()
	-- Requires the VimTeX plugin
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- Greek letter tiggers
local trig1 = "g"
local trig2 = {
	{ "a", "\\alpha" },
	{ "b", "\\beta" },
	{ "g", "\\gamma" },
	{ "G", "\\Gamma" },
	{ "d", "\\delta" },
	{ "D", "\\Delta" },
	{ "ep", "\\epsilon" },
	{ "vep", "\\varepsilon" },
	{ "z", "\\zeta" },
	{ "et", "\\eta" },
	{ "th", "\\theta" },
	{ "Th", "\\Theta" },
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
	{ "ta", "\\tau" },
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
return {
	(function()
		local greek = {}
		for _, v in ipairs(trig2) do
			greek[#greek + 1] = s(
				{ trig = trig1 .. v[1], snippetType = "autosnippet" },
				t(v[2]),
				{ condition = in_mathzone }
			)
		end
		return unpack(greek)
	end)(),

	-- Inline math
	s("im", fmta("\\(<>\\)", { i(1) })),

	-- Display math
	s("dm", fmta("\\[<>\\]", { i(1) })),

	-- Chemical equation
	-- Requires mhchem package
	s({ trig = "ce", snippetType = "autosnippet" }, fmta("\\ce{<>}", { i(1) }), { condition = in_mathzone }),

	-- Equation environment
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

	-- Align environment
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

	-- Array environment
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

	-- Square bracket matrix environment
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

	-- Expanding brackets
	s({ trig = "lrb", snippetType = "autosnippet" }, fmta("\\left(<>\\right)", { i(1) }), { condition = in_mathzone }),

	-- Expanding square brackets
	s({ trig = "lrs", snippetType = "autosnippet" }, fmta("\\left[<>\\right]", { i(1) }), { condition = in_mathzone }),

	-- Expanding curly brackets
	s(
		{ trig = "lrc", snippetType = "autosnippet" },
		fmta("\\left\\{<>\\right\\}", { i(1) }),
		{ condition = in_mathzone }
	),

	-- Text formatting
	s({ trig = "tt", snippetType = "autosnippet" }, fmta("\\text{<>}", { i(1) }), { condition = in_mathzone }),

	-- Bold formatting
	s({ trig = "bf", snippetType = "autosnippet" }, fmta("\\mathbf{<>}", { i(1) }), { condition = in_mathzone }),

	-- Bold formatting for symbols
	s({ trig = "sbf", snippetType = "autosnippet" }, fmta("\\boldsymbol{<>}", { i(1) }), { condition = in_mathzone }),

	-- Roman math
	s({ trig = "mrm", snippetType = "autosnippet" }, fmta("\\mathrm{<>}", { i(1) }), { condition = in_mathzone }),

	-- Roman text
	s({ trig = "trm", snippetType = "autosnippet" }, fmta("\\textrm{<>}", { i(1) }), { condition = in_mathzone }),

	-- Caligraphic math
	s({ trig = "cal", snippetType = "autosnippet" }, fmta("\\mathcal{<>}", { i(1) }), { condition = in_mathzone }),

	-- Blackboard bold math
	s({ trig = "bb", snippetType = "autosnippet" }, fmta("\\mathbb{<>}", { i(1) }), { condition = in_mathzone }),

	-- Subscript
	s(
		{ trig = "([%a%)%]%}])ss", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Text subscript
	s(
		{ trig = "([%a%)%]%}])ts", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{\\text{<>}}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Multiplication dot
	s({ trig = "cd", snippetType = "autosnippet" }, t("\\cdot"), { condition = in_mathzone }),

	-- Multiplication X
	s({ trig = "xx", snippetType = "autosnippet" }, t("\\times"), { condition = in_mathzone }),

	-- Division
	s({ trig = "div", snippetType = "autosnippet" }, t("\\div"), { condition = in_mathzone }),

	-- Fraction
	s(
		{ trig = "ff", snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", { i(1), i(2) }),
		{ condition = in_mathzone }
	),

	-- Inverting
	s(
		{ trig = "([%a%d%)%]%}])iv", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{-1}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- Squaring
	s(
		{ trig = "([%a%d%)%]%}])sr", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{2}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- Cubing
	s(
		{ trig = "([%a%d%)%]%}])cb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{3}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- Raising to a power
	s(
		{ trig = "([%a%d%)%]%}])rd", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Square root
	s({ trig = "sq", snippetType = "autosnippet" }, fmta("\\sqrt{<>}", { i(1) }), { condition = in_mathzone }),

	-- Centered elipses
	s({ trig = "cel", snippetType = "autosnippet" }, t("\\cdots"), { condition = in_mathzone }),

	-- Elipses
	s({ trig = "el", snippetType = "autosnippet" }, t("\\ldots"), { condition = in_mathzone }),

	-- Differential
	-- Requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	s({ trig = "df", snippetType = "autosnippet" }, t("\\diff"), { condition = in_mathzone }),

	-- Partial
	s({ trig = "pt", snippetType = "autosnippet" }, t("\\partial"), { condition = in_mathzone }),

	-- Higher order differential
	-- Requires `\newcommand*\Diff[1]{\mathop{}\!\mathrm{d^#1}}`
	s({ trig = "Df", snippetType = "autosnippet" }, fmta("\\Diff{<>}", { i(1) }), { condition = in_mathzone }),

	-- Higher order partial
	s({ trig = "Pt", snippetType = "autosnippet" }, fmta("\\partial^{<>}", { i(1) }), { condition = in_mathzone }),

	-- Derivative
	-- Requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	s(
		{ trig = "dv", snippetType = "autosnippet" },
		fmta("\\frac{\\diff <>}{\\diff <>}", { i(1), i(2) }),
		{ condition = in_mathzone }
	),

	-- Partial derivative
	s(
		{ trig = "pd", snippetType = "autosnippet" },
		fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) }),
		{ condition = in_mathzone }
	),

	-- Higher order derivative
	-- Requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	-- Requires `\newcommand*\Diff[1]{\mathop{}\!\mathrm{d^#1}}`
	s(
		{ trig = "Dv", snippetType = "autosnippet" },
		fmta("\\frac{\\Diff{<>}<>}{\\diff <>^<>}", { i(1), i(2), i(3), rep(1) }),
		{ condition = in_mathzone }
	),

	-- Higher order partial derivative
	s(
		{ trig = "Pd", snippetType = "autosnippet" },
		fmta("\\frac{\\partial^{<>}<>}{\\partial <>^<>}", { i(1), i(2), i(3), rep(1) }),
		{ condition = in_mathzone }
	),

	-- First derivative Newton's notation
	s({ trig = "dot", snippetType = "autosnippet" }, fmta("\\dot{<>}", { i(1) }), { condition = in_mathzone }),

	-- Second derivative Newton's notation
	s({ trig = "ddot", snippetType = "autosnippet" }, fmta("\\ddot{<>}", { i(1) }), { condition = in_mathzone }),

	-- Third derivative Newton's notation
	s({ trig = "dddot", snippetType = "autosnippet" }, fmta("\\dddot{<>}", { i(1) }), { condition = in_mathzone }),

	-- Integral
	s({ trig = "int", snippetType = "autosnippet" }, t("\\int"), { condition = in_mathzone }),

	-- Double integral
	s({ trig = "iint", snippetType = "autosnippet" }, t("\\iint"), { condition = in_mathzone }),

	-- Triple integral
	s({ trig = "iiint", snippetType = "autosnippet" }, t("\\iiint"), { condition = in_mathzone }),

	-- Defined integral
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

	-- Defined triple integral
	s(
		{ trig = "diiint", snippetType = "autosnippet" },
		fmta("\\int_{<>}^{<>}\\int_{<>}^{<>}\\int_{<>}^{<>}", { i(1), i(2), i(3), i(4), i(5), i(6) }),
		{ condition = in_mathzone }
	),

	-- Sine
	s({ trig = "sin", snippetType = "autosnippet" }, t("\\sin"), { condition = in_mathzone }),

	-- Cosine
	s({ trig = "cos", snippetType = "autosnippet" }, t("\\cos"), { condition = in_mathzone }),

	-- Tangent
	s({ trig = "tan", snippetType = "autosnippet" }, t("\\tan"), { condition = in_mathzone }),

	-- Arcsine
	s({ trig = "asin", snippetType = "autosnippet" }, t("\\arcsin"), { condition = in_mathzone }),

	-- Arccosine
	s({ trig = "acos", snippetType = "autosnippet" }, t("\\arccos"), { condition = in_mathzone }),

	-- Arctangent
	s({ trig = "atan", snippetType = "autosnippet" }, t("\\arctan"), { condition = in_mathzone }),

	-- Cosecant
	s({ trig = "csc", snippetType = "autosnippet" }, t("\\csc"), { condition = in_mathzone }),

	-- Secant
	s({ trig = "sec", snippetType = "autosnippet" }, t("\\sec"), { condition = in_mathzone }),

	-- Cotangent
	s({ trig = "cot", snippetType = "autosnippet" }, t("\\cot"), { condition = in_mathzone }),
}
