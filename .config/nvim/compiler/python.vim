if exists("current_compiler")
  finish
endif
let current_compiler = "python"

CompilerSet errorformat=\%*\\sFile\ \"%f\"\\,\ line\ %l\\,\ %m,\%*\\sFile\ \"%f\"\\,\ line\ %l
CompilerSet makeprg=python3\ %
