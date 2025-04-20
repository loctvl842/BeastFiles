jump() {
  if [ $# -gt 0 ]; then
    SEARCH_DIRS=("$@")
  else
    # Default to HOME if no arguments
    SEARCH_DIRS=("${HOME}")
  fi

  TARGET_DIR=$(
    for dir in "${SEARCH_DIRS[@]}"; do
      # Expand any path that might start with ~
      dir="${dir/#\~/$HOME}"
      # Check if directory exists before searching
      if [ -d "$dir" ]; then
        fd --type d --hidden --exclude .git --follow . "$dir"
      fi
    done | fzf --height 20% --reverse --prompt="Select directory: "
  )

  if [ -n "$TARGET_DIR" ]; then
    cd "$TARGET_DIR" || {
      echo "Failed to change directory to $TARGET_DIR" >&2
      return 1
    }
    echo "Changed directory to: $(pwd)"
    zle accept-line
  else
    echo "No directory selected." >&2
    return 1
  fi
}

jump_widget() {
  local old_buffer=$BUFFER
  
  # Call the jump function with fixed directories
  jump ~/Documents ~/Downloads ~/BeastFiles
  
  # If jump was successful, update the prompt
  # This avoids using zle accept-line inside jump function
  zle reset-prompt
  return 0
}

# Register the widget properly
zle -N jump_widget
bindkey '^F' jump_widget
