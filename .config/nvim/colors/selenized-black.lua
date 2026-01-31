local selenized_black = {
	bg_0 = "#181818",
	bg_1 = "#252525",
	bg_2 = "#3b3b3b",
	dim_0 = "#777777",
	fg_0 = "#b9b9b9",
	fg_1 = "#dedede",
	red = "#ed4a46",
	green = "#70b433",
	yellow = "#dbb32d",
	blue = "#368aeb",
	magenta = "#eb6eb7",
	cyan = "#3fc5b7",
	orange = "#e67f43",
	violet = "#a580e2",
	br_red = "#ff5e56",
	br_green = "#83c746",
	br_yellow = "#efc541",
	br_blue = "#4f9cfe",
	br_magenta = "#ff81ca",
	br_cyan = "#56d8c9",
	br_orange = "#fa9153",
	br_violet = "#b891f5",
}

local highlight = function(name, val)
	val = val or { fg = "fg", bg = "bg" }
	if type(val) == "string" then
		val = { link = val }
	end

	-- Force links
	val.force = true

	-- Make sure that `cterm` attribute is not populated from `gui`
	val.cterm = val.cterm or {}

	-- Define global highlight
	vim.api.nvim_set_hl(0, name, val)
end

local highlights = function(colors)
	vim.cmd.hi("clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd.syntax("reset")
	end

	vim.g.colors_name = "selenized-black"

	vim.g.terminal_color_0 = colors.bg_1
	vim.g.terminal_color_1 = colors.red
	vim.g.terminal_color_2 = colors.green
	vim.g.terminal_color_3 = colors.yellow
	vim.g.terminal_color_4 = colors.blue
	vim.g.terminal_color_5 = colors.magenta
	vim.g.terminal_color_6 = colors.cyan
	vim.g.terminal_color_7 = colors.dim_0
	vim.g.terminal_color_8 = colors.bg_2
	vim.g.terminal_color_9 = colors.br_red
	vim.g.terminal_color_10 = colors.br_green
	vim.g.terminal_color_11 = colors.br_yellow
	vim.g.terminal_color_12 = colors.br_blue
	vim.g.terminal_color_13 = colors.br_magenta
	vim.g.terminal_color_14 = colors.br_cyan
	vim.g.terminal_color_15 = colors.fg_1

	local hi = {}

	-- Builtin
	hi["ColorColumn"] = { fg = "NONE", bg = colors.bg_2 }
	hi["Conceal"] = { fg = "NONE", bg = "NONE" }
	hi["CurSearch"] = { fg = colors.br_yellow, bg = "NONE", reverse = true }
	hi["Cursor"] = { fg = "NONE", bg = "NONE", reverse = true }
	hi["CursorColumn"] = { fg = "NONE", bg = colors.bg_1 }
	hi["CursorLine"] = { fg = "NONE", bg = colors.bg_1 }
	hi["CursorLineNr"] = { fg = colors.fg_1, bg = colors.bg_1 }
	hi["DiffAdd"] = { fg = colors.green, bg = colors.bg_1 }
	hi["DiffChange"] = { fg = "NONE", bg = colors.bg_1 }
	hi["DiffDelete"] = { fg = colors.red, bg = colors.bg_1 }
	hi["DiffText"] = { fg = colors.bg_1, bg = colors.yellow }
	hi["Directory"] = { fg = colors.blue, bg = "NONE" }
	hi["EndOfBuffer"] = { fg = "NONE", bg = "NONE" }
	hi["ErrorMsg"] = { fg = "NONE", bg = "NONE" }
	hi["FloatBorder"] = "Normal"
	hi["FloatTitle"] = { fg = colors.dim_0, bg = colors.bg_0 }
	hi["FoldColumn"] = { fg = "NONE", bg = colors.bg_1 }
	hi["Folded"] = { fg = "NONE", bg = colors.bg_1 }
	hi["IncSearch"] = { fg = colors.orange, bg = "NONE", reverse = true }
	hi["LineNr"] = { fg = colors.dim_0, bg = colors.bg_0 }
	hi["MatchParen"] = { fg = colors.yellow, bg = "NONE", bold = true }
	hi["ModeMsg"] = { fg = "NONE", bg = "NONE" }
	hi["MoreMsg"] = { fg = "NONE", bg = "NONE" }
	hi["NonText"] = { fg = "NONE", bg = "NONE" }
	hi["Normal"] = { fg = colors.fg_0, bg = "NONE" }
	hi["NormalFloat"] = "Normal"
	hi["Pmenu"] = { fg = "NONE", bg = colors.bg_1 }
	hi["PmenuSbar"] = { fg = "NONE", bg = colors.bg_2 }
	hi["PmenuSel"] = { fg = "NONE", bg = colors.bg_2 }
	hi["PmenuThumb"] = { fg = "NONE", bg = colors.dim_0 }
	hi["Question"] = { fg = "NONE", bg = "NONE" }
	hi["QuickFixLine"] = "Search"
	hi["Search"] = { fg = colors.yellow, bg = "NONE", reverse = true }
	hi["SignColumn"] = { fg = "NONE", bg = colors.bg_0 }
	hi["SnippetTabstop"] = { fg = "NONE", bg = colors.bg_1, italic = true }
	hi["SpecialKey"] = { fg = "NONE", bg = "NONE" }
	hi["SpellBad"] = { fg = "NONE", bg = "NONE", sp = colors.red, undercurl = true }
	hi["SpellCap"] = { fg = "NONE", bg = "NONE", sp = colors.red, undercurl = true }
	hi["SpellLocal"] = { fg = "NONE", bg = "NONE", sp = colors.yellow, undercurl = true }
	hi["SpellRare"] = { fg = "NONE", bg = "NONE", sp = colors.cyan, undercurl = true }
	hi["StatusLine"] = { fg = "NONE", bg = colors.bg_1 }
	hi["StatusLineNC"] = { fg = colors.dim_0, bg = colors.bg_1 }
	hi["StatusLineTerm"] = "StatusLine"
	hi["StatusLineTermNC"] = "StatusLineNC"
	hi["TabLine"] = { fg = colors.fg_0, bg = colors.bg_1 }
	hi["TabLineFill"] = { fg = colors.fg_0, bg = colors.bg_1 }
	hi["TabLineSel"] = { fg = colors.fg_1, bg = colors.bg_2 }
	hi["Title"] = { fg = "NONE", bg = "NONE" }
	hi["Visual"] = { fg = "NONE", bg = colors.bg_1 }
	hi["VisualNOS"] = { fg = "NONE", bg = "NONE" }
	hi["WarningMsg"] = { fg = colors.yellow, bg = "NONE" }
	hi["WildMenu"] = { fg = "NONE", bg = "NONE" }
	hi["WinBar"] = { fg = colors.dim_0, bg = colors.bg_0 }
	hi["WinSeparator"] = { fg = colors.bg_2, bg = "NONE", bold = true }
	hi["lCursor"] = "Cursor"

	-- Extra
	hi["Added"] = { fg = colors.br_green }
	hi["Boolean"] = "Constant"
	hi["Changed"] = { fg = colors.br_blue }
	hi["Character"] = "Constant"
	hi["Comment"] = { fg = colors.green, bg = "NONE" }
	hi["Conditional"] = "Statement"
	hi["Constant"] = { fg = colors.blue, bg = "NONE" }
	hi["Delimiter"] = "Normal"
	hi["Error"] = { fg = colors.red, bg = "NONE", bold = true }
	hi["Exception"] = "Statement"
	hi["Float"] = "Constant"
	hi["Function"] = "Identifier"
	hi["Identifier"] = "Normal"
	hi["Ignore"] = { fg = colors.bg_2, bg = "NONE" }
	hi["Keyword"] = "Statement"
	hi["Label"] = "Statement"
	hi["Number"] = "Constant"
	hi["Operator"] = "Normal"
	hi["PreProc"] = "Statement"
	hi["Removed"] = { fg = colors.br_red }
	hi["Repeat"] = "Statement"
	hi["Special"] = { fg = "NONE", bg = "NONE", bold = true }
	hi["SpecialChar"] = { fg = colors.violet, bg = "NONE" }
	hi["Statement"] = { fg = colors.fg_1, bg = "NONE", bold = true }
	hi["StorageClass"] = "Type"
	hi["String"] = { fg = colors.cyan, bg = "NONE" }
	hi["Structure"] = "Type"
	hi["Terminal"] = { fg = "NONE", bg = "NONE" }
	hi["Todo"] = "Comment"
	hi["ToolbarButton"] = { fg = "NONE", bg = "NONE", reverse = true }
	hi["ToolbarLine"] = { fg = "NONE", bg = colors.bg_2 }
	hi["Type"] = { fg = colors.dim_0, bg = "NONE" }
	hi["Typedef"] = "Type"
	hi["Underlined"] = { fg = colors.blue, bg = "NONE", underline = true }
	hi["VimCommand"] = { fg = colors.yellow, bg = "NONE" }

	-- Builtin diagnostic
	hi["DiagnosticError"] = { fg = colors.red, bg = hi["SignColumn"].bg }
	hi["DiagnosticHint"] = { fg = colors.yellow, bg = hi["SignColumn"].bg }
	hi["DiagnosticInfo"] = { fg = colors.blue, bg = hi["SignColumn"].bg }
	hi["DiagnosticWarn"] = { fg = colors.yellow, bg = hi["SignColumn"].bg }
	hi["DiagnosticUnderlineError"] = { fg = hi["DiagnosticError"].fg, underline = true, sp = hi["DiagnosticError"].fg }
	hi["DiagnosticUnderlineHint"] = { fg = hi["DiagnosticHint"].fg, underline = true, sp = hi["DiagnosticWarn"].fg }
	hi["DiagnosticUnderlineInfo"] = { fg = hi["DiagnosticInfo"].fg, underline = true, sp = hi["DiagnosticInfo"].fg }
	hi["DiagnosticUnderlineWarn"] = { fg = hi["DiagnosticWarn"].fg, underline = true, sp = hi["DiagnosticHint"].fg }
	hi["DiagnosticVirtualLinesWarn"] = { fg = hi["DiagnosticWarn"].fg, bg = "NONE" }

	-- Dosini
	hi["dosiniLabel"] = "Normal"

	-- TeX
	hi["texOptEqual"] = "Normal"

	-- Identifiers
	hi["@constant"] = "Constant"
	hi["@constant.builtin"] = "Constant"
	hi["@constant.macro"] = "Define"
	hi["@label"] = "Label"
	hi["@module"] = "Identifier"
	hi["@module.builtin"] = "Special"
	hi["@variable"] = "Identifier"
	hi["@variable.builtin"] = "Special"
	hi["@variable.member"] = "Identifier"
	hi["@variable.parameter"] = "Identifier"
	hi["@variable.parameter.builtin"] = "Special"

	-- Literals
	hi["@boolean"] = "Boolean"
	hi["@character"] = "Character"
	hi["@character.special"] = "SpecialChar"
	hi["@number"] = "Number"
	hi["@number.float"] = "Float"
	hi["@string"] = "String"
	hi["@string.documentation"] = "Comment"
	hi["@string.escape"] = "SpecialChar"
	hi["@string.regexp"] = "SpecialChar"
	hi["@string.special"] = "SpecialChar"
	hi["@string.special.path"] = "SpecialChar"
	hi["@string.special.symbol"] = "SpecialChar"
	hi["@string.special.url"] = "Underlined"

	-- Types
	hi["@attribute"] = "Macro"
	hi["@attribute.builtin"] = "Special"
	hi["@property"] = "Identifier"
	hi["@type"] = "Type"
	hi["@type.builtin"] = "Special"
	hi["@type.definition"] = "TypeDef"

	-- Functions
	hi["@constructor"] = "Normal"
	hi["@function"] = "Function"
	hi["@function.builtin"] = "Special"
	hi["@function.call"] = "Function"
	hi["@function.macro"] = "Macro"
	hi["@function.method"] = "Function"
	hi["@function.method.call"] = "Function"
	hi["@operator"] = "Operator"

	-- Keywords
	hi["@keyword"] = "Keyword"
	hi["@keyword.conditional"] = "Conditional"
	hi["@keyword.conditional.ternary"] = "Conditional"
	hi["@keyword.coroutine"] = "Special"
	hi["@keyword.debug"] = "Debug"
	hi["@keyword.directive"] = "Define"
	hi["@keyword.directive.define"] = "Define"
	hi["@keyword.exception"] = "Exception"
	hi["@keyword.function"] = "Keyword"
	hi["@keyword.import"] = "Include"
	hi["@keyword.luadoc"] = { bold = false, nocombine = true }
	hi["@keyword.modifier"] = "Keyword"
	hi["@keyword.operator"] = "Operator"
	hi["@keyword.repeat"] = "Repeat"
	hi["@keyword.return"] = "Statement"
	hi["@keyword.type"] = "Keyword"

	-- Punctuation
	hi["@punctuation.bracket"] = "Delimiter"
	hi["@punctuation.delimiter"] = "Delimiter"
	hi["@punctuation.special"] = "Delimiter"

	-- Comments
	hi["@comment"] = "Comment"
	hi["@comment.documentation"] = "Comment"

	-- Diff
	hi["@diff.delta"] = "Changed"
	hi["@diff.minus"] = "Removed"
	hi["@diff.plus"] = "Added"

	-- Tags
	hi["@tag"] = "Tag"
	hi["@tag.attribute"] = "Identifier"
	hi["@tag.builtin"] = "Special"
	hi["@tag.delimiter"] = "Delimiter"

	-- Markup
	hi["@markup.raw"] = { bg = colors.bg_1 }
	hi["@markup.heading"] = { fg = colors.fg_1, bold = true }
	hi["@markup.link.url"] = "Underlined"

	-- render-markdown.vim
	hi["RenderMarkdownCode"] = "@markup.raw"

	for group, highlights in pairs(hi) do
		highlight(group, highlights)
	end
end

highlights(selenized_black)
