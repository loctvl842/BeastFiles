autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey -s '^V' 'nvim^M'
bindkey -s '^o' 'ranger^M'
bindkey -s '^[n' 'neofetch\n'
bindkey -M menuselect '^[[Z' reverse-menu-complete
