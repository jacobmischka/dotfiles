#!/usr/bin/env sh

dconf load /org/gnome/shell/keybindings/ < ~/.dotfiles/dconf/org.gnome.shell.keybindings
dconf load /org/gnome/desktop/keybindings/ < ~/.dotfiles/dconf/org.gnome.desktop.keybindings
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/.dotfiles/dconf/org.gnome.settings-daemon.plugins.media-keys
