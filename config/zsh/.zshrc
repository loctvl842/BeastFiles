[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
# Created by newuser for 5.9

# Theme
# plug "$HOME/.config/zsh/themes/beast.zsh"
# source ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
# source ~/.config/zsh/themes/powerlevel10k/config/p10k-rainbow.zsh
# [[ ! -f ~/.config/zsh/themes/.p10k.zsh ]] || source ~/.config/zsh/themes/.p10k.zsh

# Source theme
plug "romkatv/powerlevel10k"
# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# plugins
plug "zap-zsh/vim"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "conda-incubator/conda-zsh-completion"

source ~/.local/share/zap/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/themes/.p10k.zsh ]] || source ~/.config/zsh/themes/.p10k.zsh

# source
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/completion.zsh"
plug "$HOME/.config/zsh/options.zsh"
plug "$HOME/.config/zsh/login.zsh"
plug "$HOME/.config/zsh/keybind.zsh"
plug "$HOME/.config/zsh/utils.zsh"

# Tools
plug "$HOME/.config/zsh/tools/conda.zsh"
plug "$HOME/.config/zsh/tools/gvm.zsh"
plug "$HOME/.config/zsh/tools/nvm.zsh"
plug "$HOME/.config/zsh/tools/pnpm.zsh"
plug "$HOME/.config/zsh/tools/pyenv.zsh"
# plug "$HOME/.config/zsh/tools/flutter.zsh"
