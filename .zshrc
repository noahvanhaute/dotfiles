# prompt
PROMPT="%F{blue}%n@%m:%~"$'\n'"%F{cyan}$ %f"

# source alias file
[ -f ~/.alias ] && source ~/.alias

# modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# keybinds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# history
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

# use completion menu
zstyle ':completion:*' menu select

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# color completions
eval "$(dircolors -b)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33

# autocomplete first menu match
setopt auto_menu menu_complete

# show dotfiles in menu
setopt globdots

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
