# pnpm
function _pnpm_lazy_load() {
  if command -v pnpm &> /dev/null; then
    echo 'pnpm is loading...'
    export PNPM_HOME="/home/loc/.local/share/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
  else
    echo "pnpm command not found. Make sure pnpm is installed and in your PATH."
  fi
}
function pnpm() {
  _pnpm_lazy_load
  command pnpm "$@"
}
# pnpm end
