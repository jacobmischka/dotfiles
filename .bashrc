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
export YARNPATH=$HOME/.config/yarn/global/node_modules/.bin
export CARGOPATH=$HOME/.cargo/bin
export PATH=$HOMEPATH:$YARNPATH:$CARGOPATH:$GOPATH/bin:$ANDROIDPATH:$PATH

# Tools
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PAGER=/bin/less

# Other exports
export PIPENV_VENV_IN_PROJECT=1

# Remove duplicates from bash history
export HISTCONTROL=ignoreboth:erasedups

# PS1
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUPSTREAM="auto"

ORANGE="\[$(tput setaf 208)\]"
YELLOW="\[$(tput setaf 190)\]"
MAGENTA="\[$(tput setaf 162)\]"
GREEN="\[$(tput setaf 154)\]"
GREY="\[$(tput setaf 245)\]"
BOLD="\[$(tput bold)\]"
RESET="\[$(tput sgr0)\]"

TIMESTAMP="[${YELLOW}\A${RESET}] "

# Reset color before output
# trap 'tput sgr0' DEBUG

export PS1="\$([[ -n \$PS1_SHOW_TIMESTAMP ]] && echo '$TIMESTAMP')${GREY}\h ${ORANGE}${BOLD}\W${RESET}${GREEN}\$(__git_ps1 ' %s' | tr -d '=')${RESET}${BOLD} \$ ${RESET}"


# Aliases
alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -a"
alias lal="ls -alh"
alias grep="grep --color=auto"
alias pacman="sudo pacman --color=auto"
alias xclip="xclip -selection clipboard"
alias open="gio open"
alias venv="python -m venv"
alias gh="github_clone"
alias strip="trim"
alias c="xclip"
alias p="xclip -o"
alias tc="trim | xclip"
alias cve="ctrl_v_enter"
alias today="date -I | tc"

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

function print_colors(){
	print_foreground_colors
	print_background_colors
}

function print_foreground_colors(){
	for C in {0..255}; do
		tput setaf $C
		echo -n "$C "
	done
	tput sgr0
	echo
}

function print_background_colors(){
	for C in {0..255}; do
		tput setab $C
		echo -n "$C "
	done
	tput sgr0
	echo
}

function swap_red_blue() {
	convert $1 -separate -swap 0,2 -combine -colorspace sRGB $1
}
