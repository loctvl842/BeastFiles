jump() {
  BASE_DIR="${HOME}"

  TARGET_DIR=$(fd --type d --hidden --exclude .git --follow . "$BASE_DIR" | fzf --height 20% --reverse --prompt="Select directory: ")

  if [ -n "$TARGET_DIR" ]; then
    cd "$TARGET_DIR" || {
      echo "Failed to change directory to $TARGET_DIR" >&2
      return 1
    }
    echo "Changed directory to: $(pwd)"
    zle accept-line
    clear
  else
    echo "No directory selected." >&2
    return 1
  fi
}
zle -N jump-widget jump
bindkey '^F' jump-widget
