# zsh-syntax-highlighting styles using WezTerm palette env vars.
# WEZTERM_VCS_* and WEZTERM_PALETTE_* are set by WezTerm's appearance.lua via
# set_environment_variables. Monokai-pro hex values are fallbacks for non-WezTerm
# sessions. Add vcs_* fields to a palette file to override the semantic defaults.

# Commands
ZSH_HIGHLIGHT_STYLES[command]="fg=${WEZTERM_VCS_CLEAN:-#a9dc76}"
ZSH_HIGHLIGHT_STYLES[alias]="fg=${WEZTERM_VCS_CLEAN:-#a9dc76}"
ZSH_HIGHLIGHT_STYLES[function]="fg=${WEZTERM_VCS_CLEAN:-#a9dc76}"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8}"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=${WEZTERM_VCS_CLEAN:-#a9dc76},underline"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=${WEZTERM_VCS_CLEAN:-#a9dc76},underline"
ZSH_HIGHLIGHT_STYLES[global-alias]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8}"
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=${WEZTERM_VCS_CLEAN:-#a9dc76},underline"

# Errors
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${WEZTERM_VCS_CONFLICT:-#ff6188},bold"
ZSH_HIGHLIGHT_STYLES[bracket-error]="fg=${WEZTERM_VCS_CONFLICT:-#ff6188},bold"

# Keywords and control flow
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=${WEZTERM_PALETTE_ACCENT6:-#ab9df2}"

# Separators and redirection
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=${WEZTERM_PALETTE_DIMMED1:-#c1c0c0}"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=${WEZTERM_PALETTE_ACCENT6:-#ab9df2}"
ZSH_HIGHLIGHT_STYLES[named-fd]="none"
ZSH_HIGHLIGHT_STYLES[numeric-fd]="none"

# Paths and globs
ZSH_HIGHLIGHT_STYLES[path]="underline"
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=${WEZTERM_PALETTE_DIMMED1:-#c1c0c0},underline"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8}"

# Strings
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=${WEZTERM_VCS_MODIFIED:-#ffd866}"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=${WEZTERM_VCS_MODIFIED:-#ffd866}"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=${WEZTERM_VCS_MODIFIED:-#ffd866}"
ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8}"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8}"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8}"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8}"

# Substitutions
ZSH_HIGHLIGHT_STYLES[command-substitution]="none"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=${WEZTERM_PALETTE_ACCENT6:-#ab9df2}"
ZSH_HIGHLIGHT_STYLES[process-substitution]="none"
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=${WEZTERM_PALETTE_ACCENT6:-#ab9df2}"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="none"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=${WEZTERM_PALETTE_ACCENT6:-#ab9df2}"

# Assignments and comments
ZSH_HIGHLIGHT_STYLES[assign]="none"
ZSH_HIGHLIGHT_STYLES[comment]="fg=${WEZTERM_PALETTE_DIMMED3:-#727072},italic"

# Bracket matching
ZSH_HIGHLIGHT_STYLES[bracket-level-1]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8},bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-2]="fg=${WEZTERM_VCS_CLEAN:-#a9dc76},bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-3]="fg=${WEZTERM_PALETTE_ACCENT6:-#ab9df2},bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-4]="fg=${WEZTERM_VCS_MODIFIED:-#ffd866},bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-5]="fg=${WEZTERM_PALETTE_ACCENT5:-#78dce8},bold"
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]="standout"
