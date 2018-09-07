#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f /usr/bin/thefuck ]] && eval $(thefuck --alias)

[[ -f ~/.profile ]] && . ~/.profile && systemctl --user import-environment PATH

