syntax match texCmd '\\definecolor' nextgroup=texDefinecolor
syntax region texDefinecolor matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell

syntax match texCmd '\\hypersetup' nextgroup=texHypersetup
syntax region texHypersetup matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell,texArg

syntax match texPgfType 'gnuplot' nextgroup=texPgfGnuplotOpt
syntax region texPgfGnuplotOpt matchgroup=Delimiter start='\[' end='\]' contained contains=@NoSpell nextgroup=texPgfGnuplotArg
syntax region texPgfGnuplotArg matchgroup=Delimiter start='\s*{' end='}' contained contains=@NoSpell

syntax match texCmd '\\pgfplotslegendfromname' nextgroup=texPgfplotslegendfromnameArg
syntax region texPgfplotslegendfromnameArg matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell

syntax match texCmd '\\begin{tblr}' nextgroup=texTblrArg
syntax region texTblrArg matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell

syntax match texCmdTikz '\\node' nextgroup=texTikzNodeOpt,texTikzNodeLabel
syntax region texTikzNodeLabel matchgroup=Delimiter start='\s*(' end=')' contained contains=@NoSpell nextgroup=texTikzNodeOpt
syntax region texTikzNodeOpt matchgroup=Delimiter start='\s*\[' end='\]' contained contains=@NoSpell nextgroup=texTikzNodeLocation

syntax match texCmd '\\usepgfplotslibrary' nextgroup=texUsepgfplotslibrary
syntax region texUsepgfplotslibrary matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell

syntax match texCmd '\\UseTblrLibrary' nextgroup=texUseTblrLibrary
syntax region texUseTblrLibrary matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell
