#!/usr/bin/env sh

dconf load /org/gnome/shell/keybindings/ < org.gnome.shell.keybindings
dconf load /org/gnome/desktop/keybindings/ < org.gnome.desktop.keybindings
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < org.gnome.settings-daemon.plugins.media-keys
