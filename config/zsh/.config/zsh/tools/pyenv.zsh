function _pyenv_lazy_load() {
  if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  fi
}

pyenv() {
  _pyenv_lazy_load
  command pyenv "$@"
}
