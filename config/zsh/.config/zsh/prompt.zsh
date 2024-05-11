#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

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

BLACK_CODE="000"
RED_CODE="202"
GREEN_CODE="002"
YELLOW_CODE="003"
BLUE_CODE="004"
MAGENTA_CODE="005"
CYAN_CODE="006"
WHITE_CODE="007"
GRAY_CODE="240"

# Define text elements
left_symbol=""
right_symbol=""
username="%n"
custom_symbol="   "
hostname="%m"
working_directory="%c"

success="${green_text}   "
error="${red_text}   "
PROMPT_STATUS="%(?:${success}:${error})"

# Assemble the prompt
MACHINE_LEFT_SEP="%F{$YELLOW_CODE}${left_symbol}%f"
MACHINE_RIGHT_SEP="%F{$YELLOW_CODE}${right_symbol}%f"
MACHINE_SYMBOL="%F{$RED_CODE}${custom_symbol}%f"
MACHINE="${bold_text}${MACHINE_LEFT_SEP}%K{$YELLOW_CODE}${black_text}${username}${MACHINE_SYMBOL}${black_text}${hostname}%k${MACHINE_RIGHT_SEP}"
PROMPT_WORKING_DIR=" ${cyan_text}${working_directory}"
PROMPT="${MACHINE}${PROMPT_WORKING_DIR}${reset_color}"

# PROMPT="%B%{$fg[blue]%}   %{$fg[white]%}%n%{$fg[red]%}   %{$fg[white]%}%m%{$fg[blue]%}  %(?:%{$fg_bold[green]%}   :%{$fg_bold[red]%}   )%{$fg[cyan]%}%c%{$reset_color%}"

PROMPT+="\$vcs_info_msg_0_"
PROMPT+="${PROMPT_STATUS}"
