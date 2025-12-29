# Oh My Posh
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\custom.omp.json" | Invoke-Expression

# Import modules
Import-Module Terminal-Icons
Import-Module posh-git

# Predictive IntelliSense (ghost text)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Enable Vi mode with custom cursor control
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Custom Vi mode indicator with ANSI cursor control
$ESC = [char]27
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler {
    param($mode)

    if ($mode -eq 'Command') {
        # Command mode: steady block cursor
        Write-Host -NoNewLine "$ESC[2 q"
    } else {
        # Insert mode: steady bar cursor
        Write-Host -NoNewLine "$ESC[6 q"
    }
}

# Tab to trigger menu completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Accept suggestions
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key Ctrl+L -Function AcceptNextSuggestionWord

# Switch between inline and list view
Set-PSReadLineKeyHandler -Key F2 -Function SwitchPredictionView

# Emacs-style bindings in insert mode
Set-PSReadLineKeyHandler -Key Ctrl+A -Function BeginningOfLine -ViMode Insert
Set-PSReadLineKeyHandler -Key Ctrl+E -Function EndOfLine -ViMode Insert
Set-PSReadLineKeyHandler -Key Ctrl+K -Function KillLine -ViMode Insert
Set-PSReadLineKeyHandler -Key Ctrl+U -Function BackwardKillLine -ViMode Insert

# Colors
Set-PSReadLineOption -Colors @{
    InlinePrediction = '#8A8A8A'
    Command = 'Yellow'
    Parameter = 'Green'
    Operator = 'Magenta'
    Variable = 'White'
    String = 'Cyan'
}

# ============================================
# DIRECTORY JUMPING WITH FZF (Ctrl+f)
# ============================================

Set-PSReadLineKeyHandler -Key Ctrl+f -ScriptBlock {
    # Default search directories
    $searchDirs = @(
        "$env:USERPROFILE\Documents",
        "$env:USERPROFILE\Downloads",
        "$env:USERPROFILE\BeastFiles"
    )

    # Collect all directories using fd
    $allDirs = @()
    foreach ($dir in $searchDirs) {
        if (Test-Path $dir) {
            $foundDirs = fd --type d --hidden --exclude .git --follow . $dir 2>$null
            if ($foundDirs) {
                $allDirs += $foundDirs
            }
        }
    }

    # Use fzf to select directory
    if ($allDirs.Count -gt 0) {
        $targetDir = $allDirs | fzf --height 40% --reverse --prompt="Select directory: "

        if ($targetDir) {
            # Insert a cd command and execute it
            [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("Set-Location '$targetDir'")
            [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
        }
    }
}

# ============================================
# NAVIGATION ALIASES
# ============================================

# Move up directories
function .. { Set-Location .. }
function ... { Set-Location ../.. }

# ============================================
# EZA ALIASES
# ============================================

# Remove default PowerShell aliases
Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
Remove-Item Alias:ll -Force -ErrorAction SilentlyContinue
Remove-Item Alias:la -Force -ErrorAction SilentlyContinue

# Basic eza parameters
$ezaParams = '--icons', '--git', '--group-directories-first'

# ls replacement
function ls { eza @ezaParams @args }
function ll { eza @ezaParams -l --header @args }
function la { eza @ezaParams -la --header @args }
function lt { eza @ezaParams -la --header --sort=modified @args }
function tree { eza @ezaParams --tree --level=2 @args }
function ltree { eza @ezaParams -l --tree --level=2 @args }

# ============================================
# GIT ALIASES
# ============================================

# Remove conflicting PowerShell git aliases
Remove-Item Alias:gc -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gcb -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gcm -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gm -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gp -Force -ErrorAction SilentlyContinue
Remove-Item Alias:gl -Force -ErrorAction SilentlyContinue

# Launch Lazygit for a better Git experience
function g { lazygit @args }

# Stage all changes
function ga { git add . @args }

# Commit changes with an editor
function gc { git commit @args }

# Commit changes with a message
function gcm { git commit -m @args }

# Push commits to the current branch
function gp { git push @args }

# Pull latest changes from the remote repository
function gpl { git pull @args }

# Show the current status of the repository
function gst { git status @args }

# Create and switch to a new branch
function gcb { git checkout -b @args }

# List all branches
function gb { git branch @args }

# Show commit logs
function gl { git log --oneline --graph --decorate @args }

# Show differences not staged for commit
function gd { git diff @args }

# Show differences between staged and last commit
function gds { git diff --staged @args }

# Clone a repository
function gcl { git clone @args }

# Remove a tracked file from the working directory and the index
function grm { git rm @args }

# Move or rename a file, a directory, or a symlink
function gmv { git mv @args }

# Reset current HEAD to the specified state
function greset { git reset @args }

# Stash the changes in a dirty working directory
function gstash { git stash @args }

# Apply the latest stashed changes and drop them from the stash list
function gstashpop { git stash pop @args }

# Tagging commands
function gtag { git tag @args }

# Merge branches
function gmerge { git merge @args }

# Rebase the current branch onto another branch
function grebase { git rebase @args }

# Fetch updates from the remote repository
function gfetch { git fetch @args }

# Show a summary of commits
function gsummary { git shortlog -sn @args }

# Interactive rebase
function grebasei { git rebase -i @args }

# Show branches merged into the current branch
function gmerged { git branch --merged @args }

# Show branches not merged into the current branch
function gunmerged { git branch --no-merged @args }

# View commit history for a specific file
function gfilelog { git log --follow -- @args }

# Amend the last commit
function gamend { git commit --amend @args }

# Show commits that are in the remote but not local
function gdiffup { git log ..@{u} @args }

