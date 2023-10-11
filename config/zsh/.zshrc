[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
# Created by newuser for 5.9

# history
HISTFILE=~/.zsh_history

# theme
plug "$HOME/.config/zsh/prompt.zsh"

# plugins
plug "zap-zsh/vim"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"

# source
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/completion.zsh"
plug "$HOME/.config/zsh/options.zsh"
plug "$HOME/.config/zsh/login.zsh"
plug "$HOME/.config/zsh/keybind.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
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
# <<< conda initialize <<<

