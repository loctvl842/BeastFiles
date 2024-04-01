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
plug "conda-incubator/conda-zsh-completion"

# source
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/completion.zsh"
plug "$HOME/.config/zsh/options.zsh"
plug "$HOME/.config/zsh/login.zsh"
plug "$HOME/.config/zsh/keybind.zsh"
plug "$HOME/.config/zsh/utils.zsh"
