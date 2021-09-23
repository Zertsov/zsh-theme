#!/usr/bin/env zsh
export PATH="/usr/local/opt/openssl/bin:$PATH"

# Source our dotfiles
for file in ~/.{alias,funcs}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# NVM
echo "Setting NVM"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# get whatever type of colors we're working with
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color'
fi

# add the 'git' part of the prompt
git_prompt() {
    # make sure it's a git repo to start with
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
        git describe --all --exact-match HEAD 2> /dev/null || \
        git rev-parse --short HEAD 2> /dev/null || \
        echo '(unknown)')"

    local statuses=()

    repoURL="$(git config --get remote.origin.url)"
    if grep -q 'chromium/src.git' <<< "${repoURL}"; then
        statuses+='*'
    else
        # Any uncommitted changes?
        if ! $(git diff --quiet --ignore-submodules --cached); then
            statuses+=('uncommitted')
        fi

        # Any unstaged changes?
        if ! $(git diff-files --quiet --ignore-submodules --); then
            statuses+=('unstaged')
        fi

        # Untracked files?
        if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            statuses+=('untracked')
        fi

        # Stashed files?
        if $(git rev-parse --verify refs/stash &>/dev/null); then
            statuses+=('stashed')
        fi
    fi

    echo -e "${1}${branchName}${2} [ ${statuses[@]} ]"
}

# set color variables
if tput setaf 1 &> /dev/null; then
	tput sgr0 # reset colors
	bold=$(tput bold)
	reset=$(tput sgr0)
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0)
	blue=$(tput setaf 33)
	cyan=$(tput setaf 37)
	green=$(tput setaf 64)
	orange=$(tput setaf 166)
	purple=$(tput setaf 125)
	red=$(tput setaf 124)
	violet=$(tput setaf 61)
	white=$(tput setaf 15)
	yellow=$(tput setaf 136)
	gray=$(tput setaf 7)
	grey=$(tput setaf 7)
else
	bold=''
	reset="\e[0m"
	black="\e[1;30m"
	blue="\e[1;34m"
	cyan="\e[1;36m"
	green="\e[1;32m"
	orange="\e[1;33m"
	purple="\e[1;35m"
	red="\e[1;31m"
	violet="\e[1;35m"
	white="\e[1;37m"
	yellow="\e[1;33m"
fi

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}"
else
	userStyle="${orange}"
fi

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}"
else
	hostStyle="${yellow}"
fi

# allow substrings
setopt PROMPT_SUBST

# make it easy for newlines
newline=$'\n'

# Set prompt
PROMPT="${newline}"
PROMPT+="%{${userStyle}%}%n" # username
PROMPT+="%{${gray}%} in "
PROMPT+="%{${green}%}%~" # working directory full path
PROMPT+="\$(git_prompt \"%{${gray}%} branch: %{${violet}%}\" \"%{${blue}%}\")" # Git repository details
PROMPT+="${newline}"
PROMPT+="%{${gray}%}→ %{${reset}%}" # `$` (and reset color)

# for multiline commands, have a nice arrow instead of default '>'
PS2="%{${yellow}%}→ %{${reset}%}"
export PS2
