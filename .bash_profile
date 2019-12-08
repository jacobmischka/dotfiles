#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f ~/.profile ]] && . ~/.profile && systemctl --user import-environment PATH

