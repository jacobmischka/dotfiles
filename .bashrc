#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Open new tab in current directory
[[ -f /etc/profile.d/vte.sh ]] && . /etc/profile.d/vte.sh

# Git prompt
[[ -f /usr/share/git/completion/git-prompt.sh ]] && . /usr/share/git/completion/git-prompt.sh
[[ -f /usr/share/git/completion/git-completion.bash ]] && . /usr/share/git/completion/git-completion.bash
[[ -f ~/.git-prompt.sh ]] && . ~/.git-prompt.sh
[[ -f ~/.git-completion.bash ]] && . ~/.git-completion.bash

# fzf extensions
[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash

# broot
[[ -f ~/.config/broot/launcher/bash/br ]] && . ~/.config/broot/launcher/bash/br

# git-subrepo
[[ -f /opt/git-subrepo/.rc ]] && . /opt/git-subrepo/.rc

# Tools
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/bin/less

# Support colors in less by default
export LESS=-R

# Custom tools
export DEV_BROWSER=firefox-developer

# NNN
export NNN_DE_FILE_MANAGER=nautilus
export NNN_COPIER="~/.dotfiles/local/bin/nnn-copier.sh"
export NNN_USE_EDITOR=1
export NNN_TMPFILE=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd

export PUB_CACHE=$HOME/.pub-cache

# Other exports
export JAVA_HOME=/usr/lib/jvm/default
export PIPENV_VENV_IN_PROJECT=1
export BAT_THEME='Monokai Extended'

# Remove duplicates from bash history
export HISTCONTROL=ignoreboth:erasedups
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

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

export PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s\007" "${PWD/#$HOME/\~}"'

# Aliases
alias vim="nvim"
alias ls="ls_fallback"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias trash="trash-put"
alias tp="trash-put"
alias grep="grep --color=auto"
alias pacman="sudo pacman --color=auto"
alias xclip="xclip -selection clipboard"
alias copy="wl-copy"
alias paste="wl-paste -n"
alias c="copy"
alias p="paste"
alias strip="trim"
alias tc="trim | copy"
alias cve="ctrl_v_enter"
alias open="gio open"
alias venv="python -m venv"
alias qrencode="qrencode -t ANSI"
alias gh="github_clone"
alias today="date -I"
alias today-long="date +'%B %d, %Y'"
alias this-minute="date +'%F %T'"
alias smartify="smartypants -a qBDeu"
alias nvim-gtk="GTK_THEME=Adwaita:dark nvim-gtk"
alias show-password="nmcli device wifi show-password"
alias fnm="fnm-initter"

# Functions
function mkcd() {
	mkdir -p "$1" && cd -P "$1"
}

function ls_fallback() {
	if hash exa 2>/dev/null; then
		exa --icons --group-directories-first "$@"
	else
		echo 'Install exa!'
		\ls "$@"
	fi
}

function github_clone() {
	git clone "git@github.com:$1.git" $2
}

function trim() {
	sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr -d '\n'
}

function normalize_whitespace() {
	tr '[[:space:]]' ' ' | sed -E 's/[[:space:]]+/ /g' | trim
}

function ctrl_v_enter() {
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

function print_colors() {
	print_foreground_colors
	print_background_colors
}

function print_foreground_colors() {
	for C in {0..255}; do
		tput setaf $C
		echo -n "$C "
	done
	tput sgr0
	echo
}

function print_background_colors() {
	for C in {0..255}; do
		tput setab $C
		echo -n "$C "
	done
	tput sgr0
	echo
}

function swap_red_blue() {
	convert "$1" -separate -swap 0,2 -combine -colorspace sRGB "$1"
}

smartify_selection() {
	p | smartify | c
}

n() {
        nnn "$@"

        if [ -f $NNN_TMPFILE ]; then
                . $NNN_TMPFILE
                rm -f $NNN_TMPFILE > /dev/null
        fi
}

# Sources .env files
# Contrary to the actual .env spec, strings with spaces must be quote-enclosed
function source-env() {
	set -o allexport
	. $1
	set +o allexport
}

function export-java() {
	export "JAVA_HOME=/usr/lib/jvm/$(\ls /usr/lib/jvm/ | fzf)"
}

function fnm-init() {
	eval "$(\fnm env)"
}

function fnm-initter() {
	if [ "$1" = "init" ]; then
		fnm-init
	else
		\fnm "$@"
	fi
}

if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

# Set GTK dark theme in Kitty windows
if [ -n "$KITTY_WINDOW_ID" ] && [ "$XDG_SESSION_TYPE" = "x11" ]; then
	xprop -f _GTK_THEME_VARIANT 8u -set _GTK_THEME_VARIANT "dark" -id $WINDOWID
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
