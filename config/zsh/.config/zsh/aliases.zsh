#!/bin/sh

# =============================================================================
# Alias Configuration File
# =============================================================================
# This script sets up various aliases to enhance the command-line experience.
# It includes shortcuts for navigation, system management, git operations, and
# more. Each section is organized for clarity and maintainability.
# =============================================================================

# ------------------------------
# General Aliases
# ------------------------------

# Clear the terminal screen
alias c='clear'

# Enhanced 'ls' using 'eza' for better visuals with icons
alias l='eza -h --icons=auto'                        # Long list with human-readable sizes
alias ls='eza --icons=auto'                           # Short list with icons
alias la='eza -a --icons=auto'                        # All files, including hidden
alias ll='eza -ha --icons=auto --sort=name --group-directories-first' # Detailed list, sorted
alias ld='eza -hD --icons=auto'                       # List directories with human-readable sizes
alias lt='eza --icons=auto --tree'                    # Display directory tree

# Always create parent directories as needed
alias mkdir='mkdir -p'

# ------------------------------
# Navigation Shortcuts
# ------------------------------

# Quick directory navigation
alias ..='cd ..'                           # Move up one directory
alias ...='cd ../..'                       # Move up two directories
alias .3='cd ../../..'                     # Move up three directories
alias .4='cd ../../../..'                  # Move up four directories
alias .5='cd ../../../../..'               # Move up five directories

# ------------------------------
# System Management
# ------------------------------

# Disk usage in human-readable format
alias df='df -h'

# Memory usage in megabytes
alias free='free -m'

# Confirm before overwriting or deleting files
alias cp='cp -i'                           # Interactive copy
alias mv='mv -i'                           # Interactive move
alias rm='rm -i'                           # Interactive remove

# Top processes consuming memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# Top processes consuming CPU
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# ------------------------------
# Git Aliases
# ------------------------------

# Checkout to master or stable branches quickly
alias m='git checkout master'
alias s='git checkout stable'

# Launch Lazygit for a better Git experience
alias g='lazygit'

# Update all Zsh plugins by pulling the latest changes from their Git repositories
alias zsh-update-plugins="find \"$ZDOTDIR/plugins\" -type d -exec test -e '{}/.git' ';' -print0 | xargs -0 -I {} git -C {} pull -q"

# ------------------------------
# Package Management (AUR Helper: yay)
# ------------------------------

# Define the AUR helper to use
aurhelper='yay'

# Package management shortcuts
alias un="$aurhelper -Rns"                            # Uninstall a package and its dependencies
alias up="$aurhelper -Syu"                            # Update system packages and AUR
alias pl="$aurhelper -Qs"                             # Search for installed packages
alias pa="$aurhelper -Ss"                             # Search for available packages
alias pc="$aurhelper -Sc"                             # Clean package cache
alias po="$aurhelper -Qtdq | $aurhelper -Rns -"      # Remove unused packages

# ------------------------------
# Mirror Management (Using Reflector)
# ------------------------------

# Update Pacman mirrorlist with the fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

# Update mirrorlist sorted by delay
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"

# Update mirrorlist sorted by score
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"

# Update mirrorlist sorted by age
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# ------------------------------
# SSH and Networking
# ------------------------------

# SSH into the Remarkable device
alias remarkable_ssh='ssh root@10.11.99.1'

# Start restreaming with port option
alias restream='restream -p'

# ------------------------------
# Enhanced Grep Commands
# ------------------------------

# Enable colored output for grep commands for better readability
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ------------------------------
# GPG Shortcuts
# ------------------------------

# Verify GPG signatures, especially for ISOs
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"

# Retrieve GPG keys from a keyserver
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Fix Arch Linux GPG keys if they break
alias archlinx-fix-keys="sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman-key --refresh-keys"

# ------------------------------
# Systemd Shortcuts
# ------------------------------

# List all enabled systemd unit files
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

# Set Java mode using SDKMAN
alias mach_java_mode='export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"'

# ------------------------------
# Neovim Shortcuts
# ------------------------------

# Open Neovim configuration directory
alias nvimrc='nvim ~/.config/nvim/'

# Open BeastVim configuration
alias bvim="NVIM_APPNAME=BeastVim nvim"

# Function to select and launch different Neovim configurations using fzf
nvims() {
  local items=("default" "NvChad" "LazyVim")
  local config

  # Prompt the user to select a Neovim configuration
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config: " --height=50% --layout=reverse --border --exit-0)

  if [[ -z $config ]]; then
    echo "No configuration selected."
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi

  # Launch Neovim with the selected configuration
  NVIM_APPNAME="$config" nvim "$@"
}

# ------------------------------
# Operating System Specific Aliases
# ------------------------------

case "$(uname -s)" in
  Darwin)
    # macOS specific aliases
    alias ls='ls -G'  # Enable colorized output for ls on macOS
    ;;
  
  Linux)
    # Linux specific aliases
    # alias ls='ls --color=auto'  # Enable colorized output for ls on Linux
    ;;
  
  CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # Windows (Cygwin/MingW) specific aliases
    # Add Windows-specific aliases here if needed
    ;;
  
  *)
    # Other Operating Systems
    # Add other OS-specific aliases here if needed
    ;;
esac

# ------------------------------
# Kubectl
# ------------------------------

# General Kubernetes Aliases
alias k="kubectl"                                             # Short for kubectl ⭐
alias kga="kubectl get all"                                   # Get all resources in the current namespace
alias kgaa="kubectl get all --all-namespaces"                 # Get all resources in all namespaces
alias kgns="kubectl get namespaces"                           # Get all namespaces
alias kctx="kubectl config use-context"                       # Switch Kubernetes context ⭐
alias kns="kubectl config set-context --current --namespace"  # Switch namespace ⭐

# Pods and Logs
alias kgp="kubectl get pods"                 # Get all pods ⭐
alias kgpn="kubectl get pods -n"             # Get pods in a specific namespace
alias kdp="kubectl describe pod"             # Describe a pod
alias kl="kubectl logs"                      # View logs from a pod ⭐
alias klf="kubectl logs -f"                  # Stream logs from a pod ⭐
alias kexec="kubectl exec -it"               # Exec into a running pod ⭐

# Deployments and Services
alias kgd="kubectl get deployments"          # Get all deployments
alias kdd="kubectl describe deployment"      # Describe a deployment
alias kgs="kubectl get svc"                  # Get all services
alias kds="kubectl describe svc"             # Describe a service

# Ingress and Nodes
alias kgi="kubectl get ingress"              # Get all ingress resources
alias kdi="kubectl describe ingress"         # Describe an ingress
alias kgn="kubectl get nodes"                # Get all nodes
alias kdn="kubectl describe node"            # Describe a node

# Applying and Deleting Resources
alias ka="kubectl apply -f"                  # Apply a resource from a file ⭐
alias kd="kubectl delete -f"                 # Delete a resource from a file
alias kdel="kubectl delete"                  # Delete resources by name ⭐

# Namespace Management
alias kcn="kubectl config set-context --current --namespace"  # Set the current namespace
alias kgsc="kubectl get secret"                               # Get secrets in the current namespace
alias kdsc="kubectl delete secret"                            # Delete a secret

# Other Shortcuts
alias kdf="kubectl describe -f"               # Describe a resource from a file
alias kpf="kubectl port-forward"              # Port-forward to a local machine ⭐
alias krs="kubectl rollout restart deployment" # Restart a deployment ⭐
alias ktop="kubectl top"                      # Display resource (CPU/memory) usage ⭐

# ------------------------------
# Git Aliases
# ------------------------------

# ⭐ Launch Lazygit for a better Git experience
alias g='lazygit'

# Update all Zsh plugins by pulling the latest changes from their Git repositories
alias zsh-update-plugins="find \"$ZDOTDIR/plugins\" -type d -exec test -e '{}/.git' ';' -print0 | xargs -0 -I {} git -C {} pull -q"

# ⭐ Stage all changes
alias ga='git add .'  # Add all changes ⭐

# ⭐ Commit changes with an editor
alias gc='git commit'  # Commit with message ⭐

# ⭐ Commit changes with a message
alias gcm='git commit -m'  # Commit with message ⭐

# ⭐ Push commits to the current branch
alias gp='git push'  # Push changes ⭐

# ⭐ Pull latest changes from the remote repository
alias gpl='git pull'  # Pull changes ⭐

# ⭐ Show the current status of the repository
alias gst='git status'  # Show status ⭐

# Create and switch to a new branch
alias gcb='git checkout -b'  # Create & checkout branch

# List all branches
alias gb='git branch'  # List branches

# Show commit logs
alias gl='git log --oneline --graph --decorate'  # Show log

# Show differences not staged for commit
alias gd='git diff'  # Show diffs

# Show differences between staged and last commit
alias gds='git diff --staged'  # Show staged diffs

# Clone a repository
alias gcl='git clone'  # Clone repository

# Remove a tracked file from the working directory and the index
alias grm='git rm'  # Remove file

# Move or rename a file, a directory, or a symlink
alias gmv='git mv'  # Move/Rename file

# Reset current HEAD to the specified state
alias greset='git reset'  # Reset

# Stash the changes in a dirty working directory
alias gstash='git stash'  # Stash changes

# Apply the latest stashed changes and drop them from the stash list
alias gstashpop='git stash pop'  # Pop stash

# Tagging commands
alias gtag='git tag'  # Manage tags

# Merge branches
alias gmerge='git merge'  # Merge branches

# Rebase the current branch onto another branch
alias grebase='git rebase'  # Rebase branch

# Fetch updates from the remote repository
alias gfetch='git fetch'  # Fetch updates

# Show a summary of commits
alias gsummary='git shortlog -sn'  # Summary of commits

# Interactive rebase
alias grebasei='git rebase -i'  # Interactive rebase

# Show branches merged into the current branch
alias gmerged='git branch --merged'  # Show merged branches

# Show branches not merged into the current branch
alias gunmerged='git branch --no-merged'  # Show unmerged branches

# View commit history for a specific file
alias gfilelog='git log --follow --'  # Log for a file

# Amend the last commit
alias gamend='git commit --amend'  # Amend commit

# Show commits that are in the remote but not local
alias gdiffup='git log ..@{u}'  # Diff with upstream

# ------------------------------
# System Health
# ------------------------------
alias topmem="ps aux --sort=-%mem | head -n 10"  # Top 10 memory-consuming processes
alias topcpu="ps aux --sort=-%cpu | head -n 10"  # Top 10 CPU-consuming processes

# ------------------------------
# Additional Aliases
# ------------------------------

# Open a specific Neovim configuration directory
alias j='z'                      # Example alias (ensure 'z' is defined elsewhere)
alias f='zi'                     # Example alias (ensure 'zi' is defined elsewhere)

# ------------------------------
# End of Alias Configuration
# ------------------------------
