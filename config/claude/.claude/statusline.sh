#!/usr/bin/env bash
# Claude Code status line: vim icon + model + context (left), vim mode (right)
input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name')
used=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')
mode=$(printf '%s' "$input" | jq -r '.vim.mode // empty')

# Left part, without the icon (the icon is 1 column wide, counted separately)
left="$model"
if [ -n "$used" ]; then
    left=$(printf '%s | Context: %.0f%% used' "$left" "$used")
fi

# No vim mode: plain single-segment status line
if [ -z "$mode" ]; then
    printf '\033[2m%s\033[0m' "$left"
    exit 0
fi

# Vim mode on: mode-colored icon, vim-style mode indicator right-aligned to
# the edge. The interface insets the statusline row ~2 columns per side, and
# the nerdfont icon renders 2 columns wide, so discount both from the width.
icon=$(printf '\356\237\205')
mode_str="-- $mode --"

case "$mode" in
    NORMAL) mode_color=$(printf '\033[36m') ;; # cyan
    INSERT) mode_color=$(printf '\033[32m') ;; # green
    VISUAL*) mode_color=$(printf '\033[35m') ;; # magenta
    *)       mode_color=$(printf '\033[32m') ;;
esac

# Cursor shape follows the mode (DECSCUSR): bar for insert, block otherwise.
# Written straight to the terminal's tty since statusline output is sanitized.
case "$mode" in
    INSERT) cursor='\033[6 q' ;;
    *)      cursor='\033[2 q' ;;
esac
tty_dev=$(ps -o tty= -p "$PPID" | tr -d ' ')
[ -n "$tty_dev" ] && [ "$tty_dev" != "??" ] && printf "$cursor" > "/dev/$tty_dev" 2>/dev/null

width=$(( ${COLUMNS:-80} - 4 ))
pad=$(( width - ${#left} - ${#mode_str} - 3 ))
[ "$pad" -lt 1 ] && pad=1

printf '\033[2m%s%s \033[0m\033[2m%s\033[0m%*s%s%s\033[0m' \
  "$mode_color" "$icon" "$left" "$pad" '' "$mode_color" "$mode_str"
