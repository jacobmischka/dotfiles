#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f ~/.profile ]] && . ~/.profile && systemctl --user import-environment PATH

# broot
[[ -f /home/mischka/.config/broot/launcher/bash/br ]] && source /home/mischka/.config/broot/launcher/bash/br
