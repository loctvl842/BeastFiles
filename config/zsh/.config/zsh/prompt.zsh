#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

precmd_get_conda_env_name() {
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
precmd_functions+=( precmd_get_conda_env_name )

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    hook_com[staged]+='!' # signify new files with a bang
  fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%{$reset_color%}"



# Define text formatting and color variables
bold_text="%B"
reset_color="%{$reset_color%}"

red_text="%{$fg[red]%}"
blue_text="%{$fg[blue]%}"
green_text="%{$fg[green]%}"
cyan_text="%{$fg[cyan]%}"
yellow_text="%{$fg[yellow]%}"
magenta_text="%{$fg[magenta]%}"
black_text="%{$fg[black]%}"
white_text="%{$fg[white]%}"

# for code in {000..255}; do print -P -- "$code: %F{$code}Color%f"; done
red_bg="%{$bg[red]%}"
blue_bg="%{$bg[blue]%}"
green_bg="%{$bg[green]%}"
cyan_bg="%{$bg[cyan]%}"
yellow_bg="%{$bg[yellow]%}"
magenta_bg="%{$bg[magenta]%}"
black_bg="%{$bg[black]%}"
white_bg="%{$bg[white]%}"

float_fg="%F{008}%f"
float_bg="%K{008}%f"

# Define text elements
left_wrap=" "
right_wrap=" "
username="%n"
custom_symbol="   "
hostname="%m"
working_directory="%c"

success="${green_text}   "
error="${red_text}   "
conditional_content="%(?:${success}:${error})"

# Assemble the prompt
machine="${left_wrap}${yellow_text}${username}${red_text}${custom_symbol}${yellow_text}${hostname}${blue_text}${right_wrap}"
PROMPT="${bold_text}${blue_text}${machine}${conditional_content}${cyan_text}${working_directory}${reset_color}"

# PROMPT="%B%{$fg[blue]%}   %{$fg[white]%}%n%{$fg[red]%}   %{$fg[white]%}%m%{$fg[blue]%}  %(?:%{$fg_bold[green]%}   :%{$fg_bold[red]%}   )%{$fg[cyan]%}%c%{$reset_color%}"

PROMPT+="\$vcs_info_msg_0_ "

# Get virtual environment name of python

RPROMPT_LEFT_SEP="%F{003}█%f"
RPROMPT_RIGHT_SEP="%F{003}█%f"
RPROMPT_CONTENT='%K{003}${black_text}${bold_text}${CONDA_ENV}%k'
RPROMPT="${RPROMPT_LEFT_SEP}${RPROMPT_CONTENT}${RPROMPT_RIGHT_SEP}"
