-- Function to pass as a condition for only triggering in math mode
local in_mathzone = function()
	-- Requires the VimTeX plugin
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local greek_letter_triggers = {
	{ "al", "\\alpha" },
	{ "be", "\\beta" },
	{ "ch", "\\chi" },
	{ "de", "\\delta" },
	{ "De", "\\Delta" },
	{ "ep", "\\epsilon" },
	{ "vep", "\\varepsilon" },
	{ "et", "\\eta" },
	{ "ga", "\\gamma" },
	{ "Ga", "\\Gamma" },
	{ "io", "\\iota" },
	{ "ka", "\\kappa" },
	{ "la", "\\lambda" },
	{ "La", "\\Lambda" },
	{ "mu", "\\mu" },
	{ "Mu", "\\Mu" },
	{ "nu", "\\nu" },
	{ "om", "\\omega" },
	{ "Om", "\\Omega" },
	{ "ph", "\\phi" },
	{ "vph", "\\varphi" },
	{ "Ph", "\\Phi" },
	{ "pi", "\\pi" },
	{ "Pi", "\\Pi" },
	{ "ps", "\\psi" },
	{ "Ps", "\\Psi" },
	{ "rh", "\\rho" },
	{ "si", "\\sigma" },
	{ "Si", "\\Sigma" },
	{ "ta", "\\tau" },
	{ "th", "\\theta" },
	{ "vth", "\\vartheta" },
	{ "Th", "\\Theta" },
	{ "up", "\\upsilon" },
	{ "Up", "\\Upsilon" },
	{ "xi", "\\xi" },
	{ "Xi", "\\Xi" },
	{ "ze", "\\zeta" },
}

local greek_snippets = (function()
	local snippets = {}
	for _, trigger in ipairs(greek_letter_triggers) do
		snippets[#snippets + 1] = s(trigger[1], t(trigger[2]), { condition = in_mathzone })
	end
	return snippets
end)()

return vim.list_extend(greek_snippets, {
	-- Inline math
	s("im", fmta("\\(<>\\)", { i(1) })),

	-- Display math
	s("dm", fmta("\\[<>\\]", { i(1) })),

	-- Chemical equation
	-- Requires mhchem package
	s("ce", fmta("\\ce{<>}", { i(1) })),

	-- Equation environment
	s(
		"eq",
		fmta(
			[=[
            \begin{equation}
                <>
                \label{eq-<>}
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
                \label{eq-<>}
            \end{align}
            ]=],
			{ i(1), i(2) }
		)
	),

	-- Array environment
	s(
		"arr",
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
		"bma",
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
	s("lrb", fmta("\\left(<>\\right)", { i(1) }), { condition = in_mathzone }),

	-- Expanding square brackets
	s("lrs", fmta("\\left[<>\\right]", { i(1) }), { condition = in_mathzone }),

	-- Expanding curly brackets
	s("lrc", fmta("\\left\\{<>\\right\\}", { i(1) }), { condition = in_mathzone }),

	-- Text formatting
	s("tt", fmta("\\text{<>}", { i(1) }), { condition = in_mathzone }),

	-- Bold formatting
	s("bf", fmta("\\mathbf{<>}", { i(1) }), { condition = in_mathzone }),

	-- Bold formatting for symbols
	s("sbf", fmta("\\boldsymbol{<>}", { i(1) }), { condition = in_mathzone }),

	-- Roman math
	s("mrm", fmta("\\mathrm{<>}", { i(1) }), { condition = in_mathzone }),

	-- Roman text
	s("trm", fmta("\\textrm{<>}", { i(1) }), { condition = in_mathzone }),

	-- Calligraphic math
	s("cal", fmta("\\mathcal{<>}", { i(1) }), { condition = in_mathzone }),

	-- Blackboard bold math
	s("bb", fmta("\\mathbb{<>}", { i(1) }), { condition = in_mathzone }),

	-- Subscript
	s(
		{ trig = "([%a%)%]%}])ss", regTrig = true, wordTrig = false },
		fmta("<>_{<>}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Text subscript
	s(
		{ trig = "([%a%)%]%}])ts", regTrig = true, wordTrig = false },
		fmta("<>_{\\text{<>}}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Roman subscript
	s(
		{ trig = "([%a%)%]%}])rs", regTrig = true, wordTrig = false },
		fmta("<>_{\\mathrm{<>}}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Superscript
	s(
		{ trig = "([%a%d%)%]%}])Ss", regTrig = true, wordTrig = false },
		fmta("<>^{<>}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Text superscript
	s(
		{ trig = "([%a%d%)%]%}])tS", regTrig = true, wordTrig = false },
		fmta("<>^{\\text{<>}}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Roman superscript
	s(
		{ trig = "([%a%d%)%]%}])rS", regTrig = true, wordTrig = false },
		fmta("<>^{\\mathrm{<>}}", { f(function(_, snip)
			return snip.captures[1]
		end), i(1) }),
		{ condition = in_mathzone }
	),

	-- Multiplication dot
	s("cd", t("\\cdot"), { condition = in_mathzone }),

	-- Multiplication X
	s("xx", t("\\times"), { condition = in_mathzone }),

	-- Division
	s("div", t("\\div"), { condition = in_mathzone }),

	-- Fraction
	s("ff", fmta("\\frac{<>}{<>}", { i(1), i(2) }), { condition = in_mathzone }),

	-- Inverting
	s(
		{ trig = "([%a%d%)%]%}])iv", regTrig = true, wordTrig = false },
		fmta("<>^{-1}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- Squaring
	s(
		{ trig = "([%a%d%)%]%}])sr", regTrig = true, wordTrig = false },
		fmta("<>^{2}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- Cubing
	s(
		{ trig = "([%a%d%)%]%}])cb", regTrig = true, wordTrig = false },
		fmta("<>^{3}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = in_mathzone }
	),

	-- Square root
	s("sq", fmta("\\sqrt{<>}", { i(1) }), { condition = in_mathzone }),

	-- Centered ellipses
	s("cel", t("\\cdots"), { condition = in_mathzone }),

	-- Ellipses
	s("el", t("\\ldots"), { condition = in_mathzone }),

	-- Differential
	-- Requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	s("df", t("\\diff"), { condition = in_mathzone }),

	-- Partial
	s("pt", t("\\partial"), { condition = in_mathzone }),

	-- Higher order differential
	-- Requires `\newcommand*\Diff[1]{\mathop{}\!\mathrm{d^#1}}`
	s("Df", fmta("\\Diff{<>}", { i(1) }), { condition = in_mathzone }),

	-- Higher order partial
	s("Pt", fmta("\\partial^{<>}", { i(1) }), { condition = in_mathzone }),

	-- Derivative
	-- Requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	s("dv", fmta("\\frac{\\diff <>}{\\diff <>}", { i(1), i(2) }), { condition = in_mathzone }),

	-- Partial derivative
	s("pd", fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) }), { condition = in_mathzone }),

	-- Higher order derivative
	-- Requires `\newcommand*\diff{\mathop{}\!\mathrm{d}}`
	-- Requires `\newcommand*\Diff[1]{\mathop{}\!\mathrm{d^#1}}`
	s("Dv", fmta("\\frac{\\Diff{<>}<>}{\\diff <>^<>}", { i(1), i(2), i(3), rep(1) }), { condition = in_mathzone }),

	-- Higher order partial derivative
	s(
		"Pd",
		fmta("\\frac{\\partial^{<>}<>}{\\partial <>^<>}", { i(1), i(2), i(3), rep(1) }),
		{ condition = in_mathzone }
	),

	-- First derivative Newton's notation
	s("d", fmta("\\dot{<>}", { i(1) }), { condition = in_mathzone }),

	-- Second derivative Newton's notation
	s("dd", fmta("\\ddot{<>}", { i(1) }), { condition = in_mathzone }),

	-- Third derivative Newton's notation
	s("ddd", fmta("\\dddot{<>}", { i(1) }), { condition = in_mathzone }),

	-- Integral
	s("i", t("\\int"), { condition = in_mathzone }),

	-- Double integral
	s("ii", t("\\iint"), { condition = in_mathzone }),

	-- Triple integral
	s("iii", t("\\iiint"), { condition = in_mathzone }),

	-- Defined integral
	s("di", fmta("\\int_{<>}^{<>}", { i(1), i(2) }), { condition = in_mathzone }),

	-- defined double integral
	s("dii", fmta("\\int_{<>}^{<>}\\int_{<>}^{<>}", { i(1), i(2), i(3), i(4) }), { condition = in_mathzone }),

	-- Defined triple integral
	s(
		"diii",
		fmta("\\int_{<>}^{<>}\\int_{<>}^{<>}\\int_{<>}^{<>}", { i(1), i(2), i(3), i(4), i(5), i(6) }),
		{ condition = in_mathzone }
	),

	-- Sine
	s("sin", t("\\sin"), { condition = in_mathzone }),

	-- Cosine
	s("cos", t("\\cos"), { condition = in_mathzone }),

	-- Tangent
	s("tan", t("\\tan"), { condition = in_mathzone }),

	-- Arcsine
	s("asin", t("\\arcsin"), { condition = in_mathzone }),

	-- Arccosine
	s("acos", t("\\arccos"), { condition = in_mathzone }),

	-- Arctangent
	s("atan", t("\\arctan"), { condition = in_mathzone }),

	-- Cosecant
	s("csc", t("\\csc"), { condition = in_mathzone }),

	-- Secant
	s("sec", t("\\sec"), { condition = in_mathzone }),

	-- Cotangent
	s("cot", t("\\cot"), { condition = in_mathzone }),
})
