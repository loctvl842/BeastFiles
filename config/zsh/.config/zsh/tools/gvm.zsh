export GVM_ROOT=$HOME/.gvm
# Lazy load gvm
gvm_lazy_load() {
  echo 'gvm is loading...'
  if [ -f "$GVM_ROOT/scripts/gvm" ]; then
    # Source gvm script if it exists
    source "$GVM_ROOT/scripts/gvm"
  else
    echo "gvm script not found. Make sure gvm is installed and configured correctly."
  fi
}

# Override the gvm command to trigger lazy loading
gvm() {
  gvm_lazy_load
  # Forward the gvm command to the actual gvm executable
  command gvm "$@"
}
