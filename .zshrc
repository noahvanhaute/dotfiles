# Prompt
PROMPT='%F{blue}%n@%m:%~'$'\n''%F{cyan}$ %f'

# Source alias file
[ -f ~/.alias ] && source ~/.alias

# Modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# Keybinds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Use completion menu
zstyle ':completion:*' menu select

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Color completions
eval "$(dircolors -b)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33

# Show dotfiles in menu
setopt globdots

# Shell integrations
# Opening yazi with `y` will change cwd on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


# Fzf colors
export FZF_DEFAULT_OPTS='--color=bg+:black,gutter:bright-black,pointer:bright-magenta,prompt:bright-magenta'

# Syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
