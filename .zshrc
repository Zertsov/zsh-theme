#============================
#           PATH            =
#============================
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

#============================
#        VIRTUALENV         =
#============================
export WORKON_HOME=$HOME/.virtualenvs
source "/usr/local/bin/virtualenvwrapper.sh"


#============================
#            GO             =
#============================
export GOPATH=$HOME/go 

#============================
#         Oh-My-ZSH         =
#============================
export ZSH=/Users/mitch/.oh-my-ZSH


#============================
#     ZSH Customizations    =
#============================
ZSH_THEME="powerlevel9k/powerlevel9k"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

plugins=(
    git common-aliases docker zsh-autosuggestions iterm-tab-colors zsh-kubernetes zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-autosuggestions

export SSH_KEY_PATH="~/.ssh/rsa_id"

#----------------------------
#          Aliases          -
#----------------------------
alias ls="ls -FG"

#----------------------------
#      Powerline Config     -
#----------------------------
local upleft=""
local upleft_unicode="\u256D"
local upright=""
local upright_unicode="\u2500"

local bottomleft=""
local bottomleft_unicode="\u2570"
local bottomright=""
local bottomright_unicode="\uf460"

DEFAULT_USER=$User
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{031}\/%F{031}"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false 
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{031}$upleft_unicode$upright_unicode%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{031}$bottomleft_unicode$bottomright_unicode%f"
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir_joined dir_writable_joined)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time vcs background_jobs_joined user_joined)

# Right side git customizations
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="clear"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="green"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"

# Directory colors
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="031"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="031"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="031"

# Root colors
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="clear"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="red"

# Status colors
POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"

# Time customizations
POWERLEVEL9K_TIME_FORMAT="%D{\uf073 %b %d \uf017 %H:%M}"
POWERLEVEL9K_TIME_BACKGROUND="clear"
POWERLEVEL9K_TIME_FOREGROUND="blue"

# Command Exe
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="clear"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="magenta"

# Background jobs
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="clear"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="magenta"

# User
POWERLEVEL9K_USER_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_USER_DEFAULT_FOREGROUND="cyan"
POWERLEVEL9K_USER_ROOT_BACKGROUND="clear"
POWERLEVEL9K_USER_ROOT_FOREGROUND="red"
POWERLEVEL9K_USER_ICON="\uf415"
POWERLEVEL9K_ROOT_ICON="\u26a1"

# Host / Remote machines
POWERLEVEL9K_HOST_LOCAL_BACKGROUND="clear"
POWERLEVEL9K_HOST_LOCAL_FOREGROUND="cyan"
POWERLEVEL9K_HOST_REMOTE_BACKGROUND="clear"
POWERLEVEL9K_HOST_REMOTE_FOREGROUND="magenta"
POWERLEVEL9K_HOST_ICON="\uF109"
POWERLEVEL9K_SSH_ICON="\uF489"
POWERLEVEL9K_OS_ICON_BACKGROUND="clear"
POWERLEVEL9K_OS_ICON_FOREGROUND="grey"


#----------------------------
#  zsh-syntax-highlighting  -
#----------------------------
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=036'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=default'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[bulitin]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[function]='fg=green'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'


#============================
#         Functions         =
#============================

vv () {
    out=$(pip -V | cut -d ' ' -f 4)

    if [[ $out != *".virtualenvs"* ]]; then
        echo "No virtualenv active"
    else 
        pip -V | cut -d ' ' -f 4 | cut -d '/' -f 5
    fi
}