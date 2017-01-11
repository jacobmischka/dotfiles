#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Open new tab in current directory
[[ -f /etc/profile.d/vte.sh ]] && . /etc/profile.d/vte.sh

# fzf extensions
[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash

#PS1='[\u@\h \W]\$ '
#white bold user:dir$ prompt
orange_color(){
	tput setaf 208
	tput bold
}
reset_color(){
	tput sgr0
}
export PS1='\[$(orange_color)\][\u@\h \W]\$ \[$(reset_color)\]'

# Paths
export GOPATH=$HOME/go
export GEMPATH=$HOME/.gem/ruby/2.3.0/bin
export VENVPATH=./venv/bin
export HOMEPATH=$HOME/.local/bin
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROIDPATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$HOMEPATH:$VENVPATH:$GOPATH/bin:$GEMPATH:$ANDROIDPATH:$PATH

# Tools
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PAGER=/bin/less

alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -a"
alias lal="ls -alh"
alias grep="grep --color=auto"
alias pacman="sudo pacman --color=auto"
alias xclip="xclip -selection clipboard"
alias open="xdg-open"
alias venv="python -m venv"
alias fuck="thefuck"
alias gh="github_clone"
alias strip="trim"
alias c="xclip"
alias tc="trim | xclip"

mkcd(){
	mkdir -p "$1" && cd -P "$1"
}

github_clone(){
	git clone "git@github.com:$1.git"
}

trim(){
	sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr -d '\n'
}
