[[ -n $PS1 ]] || return

if [[ -f /usr/share/bash-completion/completions/git-prompt.sh ]]; then
	source /usr/share/bash-completion/completions/git-prompt.sh
fi

stty -ixon

make-prompt() {
    local BLUE='\[\e[34m\]'
    local CYAN='\[\e[36m\]'
    local RESET='\[\e[0m\]'

    PROMPT_COMMAND="__git_ps1 '${BLUE}\u@\h:\w' '\n${CYAN}\$ ${RESET}'"
}
make-prompt

complete -d cd

alias ls='ls --color'
alias vim='nvim'

HISTCONTROL=erasedups:ignoredups

export GIT_PS1_SHOWUPSTREAM="auto"
