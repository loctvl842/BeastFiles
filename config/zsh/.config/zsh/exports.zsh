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

export GOPATH=$HOME/.local/share/go

########## colorls ##################
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export LC_ALL=en_US.UTF-8
export LS_COLORS="ow=01;36;40:${LS_COLORS}"
export CLICOLOR_FORCE=true

# Lazy load Conda
conda() {
  __conda_setup="$('/home/loc/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/home/loc/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/home/loc/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/home/loc/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
    if command -v conda &> /dev/null; then
        echo "Conda is already loaded."
    else
        __conda_setup="$('/home/loc/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/home/loc/miniconda3/etc/profile.d/conda.sh" ]; then
                . "/home/loc/miniconda3/etc/profile.d/conda.sh"
            else
                export PATH="/home/loc/miniconda3/bin:$PATH"
            fi
        fi
        unset __conda_setup
    fi
}

### java application
export _JAVA_AWT_WM_NONREPARENTING=1

# pnpm
pnpm_lazy_load() {
  echo 'pnpm is loading...'
  if command -v pnpm &> /dev/null; then
    export PNPM_HOME="/home/loc/.local/share/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
  else
    echo "pnpm command not found. Make sure pnpm is installed and in your PATH."
  fi
}
pnpm() {
  pnpm_lazy_load
  command pnpm "$@"
}
# pnpm end

export NVM_DIR="$HOME/.nvm"
nvm_lazy_load() {
  echo 'nvm is loading...'
  if command -v nvm &> /dev/null; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  else
    echo "nvm command not found. Make sure nvm is installed and in your PATH."
  fi
}

# Use a command that triggers nvm_lazy_load when needed
nvm() {
  nvm_lazy_load
  command nvm "$@"
}

# # react native tools
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/platform-tools
#
# Flutter
export ANDROID_HOME=$HOME/andoird-sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export CXX=clang++
