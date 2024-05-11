function _precmd_get_conda_env_name() {
  if [[ -n $CONDA_PREFIX ]]; then
    if [[ $(basename $CONDA_PREFIX) == "miniconda3" ]]; then
      CONDA_ENV="base"
    else
      CONDA_ENV="$(basename $CONDA_PREFIX)"
    fi
  else
    CONDA_ENV=""
  fi
}
# Zsh executes all functions listed in the precmd_functions array immediately
# before displaying the prompt
precmd_functions+=( _precmd_get_conda_env_name )

function _setup_rpompt_env() {
  __conda_setup="$('/home/loc/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  RPROMPT_LEFT_SEP="%F{$YELLOW_CODE}%f"
  RPROMPT_RIGHT_SEP="%F{$YELLOW_CODE}%f"
  RPROMPT_CONTENT='%K{$YELLOW_CODE}${black_text}${bold_text}${CONDA_ENV}%k'
  RPROMPT="${RPROMPT_LEFT_SEP}${RPROMPT_CONTENT}${RPROMPT_RIGHT_SEP}"
}

# Get virtual environment name of python
if [[ -n $CONDA_ENV ]]; then
  _setup_rpompt_env
fi

# Lazy load Conda
function conda() {
  __conda_setup="$('/home/loc/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  export CONDA_ENV="base"
  _setup_rpompt_env

  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/home/loc/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/home/loc/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/home/loc/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
    if command -v conda &> /dev/null; then
      echo "Conda is already loaded."
    else
      __conda_setup="$('/home/loc/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
        eval "$__conda_setup"
      else
        if [ -f "/home/loc/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/home/loc/miniconda3/etc/profile.d/conda.sh"
        else
          export PATH="/home/loc/miniconda3/bin:$PATH"
        fi
      fi
      unset __conda_setup
    fi
}
