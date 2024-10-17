#!/bin/sh
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="flatpak run com.brave.Browser"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$PATH:$HOME/.dotnet/tools
export GOPATH=$HOME/.local/share/go
export GTK_THEME="WhiteSur-Dark-solid"

########## colorls ##################
# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# export PATH="$PATH:$GEM_HOME/bin"
# export LC_ALL=en_US.UTF-8
# export LS_COLORS="ow=01;36;40:${LS_COLORS}"
# export CLICOLOR_FORCE=true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/loc/google-cloud-sdk/path.zsh.inc' ]; then . '/home/loc/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/loc/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/loc/google-cloud-sdk/completion.zsh.inc'; fi
