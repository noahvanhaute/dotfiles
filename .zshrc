PROMPT='%F{blue}%n@%m:%~'$'\n''%F{cyan}$ %f'

[ -f ~/.alias ] && source ~/.alias

zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

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

# Show dotfiles in completion menu
setopt globdots

# nvm stuff
export NVM_DIR="$HOME/.nvm"
# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# Load nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export FZF_DEFAULT_OPTS='--color=bg+:black,gutter:bright-black,pointer:bright-magenta,prompt:bright-magenta'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
