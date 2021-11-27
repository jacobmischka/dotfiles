#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -f ~/.profile ]]; then
	. ~/.profile
	hash systemctl 2>/dev/null && systemctl --user import-environment PATH
fi
