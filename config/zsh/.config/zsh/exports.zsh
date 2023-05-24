#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.fnm:$PATH
# react native tools
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export GOPATH=$HOME/.local/share/go
# export PATH="$PATH:./node_modules/.bin"
eval "$(fnm env)"
eval "$(zoxide init zsh)"
eval "`pip completion --zsh`"

########## colorls ##################
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export LC_ALL=en_US.UTF-8
export LS_COLORS="ow=01;36;40:${LS_COLORS}"
export CLICOLOR_FORCE=true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/.miniconda/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/.miniconda/etc/profile.d/conda.sh" ]; then
    . "$HOME/.miniconda/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/.miniconda/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

### java application
export _JAVA_AWT_WM_NONREPARENTING=1
