#!/usr/bin/env sh

dconf dump /org/gnome/shell/keybindings/ > ~/.dotfiles/dconf/org.gnome.shell.keybindings
dconf dump /org/gnome/desktop/keybindings/ > ~/.dotfiles/dconf/org.gnome.desktop.keybindings
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > ~/.dotfiles/dconf/org.gnome.settings-daemon.plugins.media-keys
dconf dump /org/gnome/terminal/legacy/ > ~/.dotfiles/dconf/org.gnome.terminal.legacy
