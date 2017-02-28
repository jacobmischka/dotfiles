#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Open new tab in current directory
[[ -f /etc/profile.d/vte.sh ]] && . /etc/profile.d/vte.sh

# Git prompt
[[ -f /usr/share/git/completion/git-prompt.sh ]] && . /usr/share/git/completion/git-prompt.sh

# fzf extensions
[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash


# Paths
export GOPATH=$HOME/go
export HOMEPATH=$HOME/.local/bin
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROIDPATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$HOMEPATH:$GOPATH/bin:$ANDROIDPATH:$PATH

# Tools
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PAGER=/bin/less

# Other exports

# Remove duplicates from bash history
export HISTCONTROL=ignoreboth:erasedups

# PS1
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUPSTREAM="auto"

export PROMPT_COMMAND='__git_ps1 "\[$(orange_color)\][\u@\h \W\[$(reset_color)\]" "\[$(orange_color)\]]\$ \[$(reset_color)\]"'

function orange_color(){
	tput setaf 208
	tput bold
}

function reset_color(){
	tput sgr0
}

# Aliases
alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -a"
alias lal="ls -alh"
alias grep="grep --color=auto"
alias pacman="sudo pacman --color=auto"
alias xclip="xclip -selection clipboard"
alias open="xdg-open"
alias venv="python -m venv"
alias gh="github_clone"
alias strip="trim"
alias c="xclip"
alias p="xclip -o"
alias tc="trim | xclip"
alias cve="ctrl_v_enter"

# Functions
function mkcd(){
	mkdir -p "$1" && cd -P "$1"
}

function github_clone(){
	git clone "git@github.com:$1.git"
}

function trim(){
	sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr -d '\n'
}

function normalize_whitespace(){
	tr '[:space:]' ' '
}

function ctrl_v_enter(){
	sleep 2

	ITERATIONS=$1

	if [ -z $ITERATIONS ]; then
		ITERATIONS=20
	fi

	for i in $(seq $ITERATIONS); do
		xdotool key ctrl+v Return
		sleep 0.01
	done
}

