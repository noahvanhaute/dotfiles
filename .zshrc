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
export LS_COLORS="$LS_COLORS:*#=00;92:*~=00;92:*.bak=00;92:*.crdownload=00;92:*.dpkg-dist=00;92:*.dpkg-new=00;92:*.dpkg-old=00;92:*.dpkg-tmp=00;92:*.old=00;92:*.orig=00;92:*.part=00;92:*.rej=00;92:*.rpmnew=00;92:*.rpmorig=00;92:*.rpmsave=00;92:*.swp=00;92:*.tmp=00;92:*.ucf-dist=00;92:*.ucf-new=00;92:*.ucf-old=00;92"
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
