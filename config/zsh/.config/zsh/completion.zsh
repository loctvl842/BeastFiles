[ -f $HOME/.config/zsh/completions/_poetry ] && fpath+=$HOME/.config/zsh/completions/

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
compinit

source <(kubectl completion zsh)
source <(docker completion zsh)
# bun completions
[ -s "/Users/loctvl842/.bun/_bun" ] && source "/Users/loctvl842/.bun/_bun"
# dotnet completions
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet
