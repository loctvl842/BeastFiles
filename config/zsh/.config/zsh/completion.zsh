[ -f $HOME/.config/zsh/completions/_poetry ] && fpath+=$HOME/.config/zsh/completions/

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
compinit

source <(kubectl completion zsh)
source <(docker completion zsh)
