function _precmd_get_poetry_env_name() {

}

# autoload -U add-zsh-hook
#
# _poetry_virtualenv_name() {
#     if [[ -n $VIRTUAL_ENV && -f "$VIRTUAL_ENV/pyproject.toml" ]]; then
#         local poetry_env_name="$(basename "$VIRTUAL_ENV")"
#         PS1="${PS1//$poetry_env_name/}"
#     fi
# }
#
# add-zsh-hook precmd _poetry_virtualenv_name
